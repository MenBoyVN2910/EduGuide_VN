import { useSuspenseQuery, useQuery, useMutation } from "@tanstack/react-query"
import { createFileRoute } from "@tanstack/react-router"
import { Suspense, useState, useRef, useEffect } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { ExternalLink, Play, Database, Table as TableIcon } from "lucide-react"
import { toast } from "sonner"
import { useTranslation } from "react-i18next"
import ForceGraph2D from "react-force-graph-2d"
import { useTheme } from "next-themes"

import { KnowledgeService } from "@/client"

function getKnowledgeStatsQueryOptions() {
  return {
    queryFn: () => KnowledgeService.getKnowledgeStats(),
    queryKey: ["knowledge-stats"],
  }
}

export const Route = createFileRoute("/_layout/admin/knowledge")({
  component: AdminKnowledge,
})

function KnowledgeContent() {
  const { data } = useSuspenseQuery(getKnowledgeStatsQueryOptions())
  const [file, setFile] = useState<File | null>(null)
  const [uploading, setUploading] = useState(false)
  const { t } = useTranslation()

  const handleUpload = async () => {
    if (!file) return

    setUploading(true)
    try {
      const result = await KnowledgeService.uploadKnowledgeDocument({
        formData: {
          file: file,
        },
      })
      toast.success(result.message)
      setFile(null)
    } catch (err) {
      toast.error(t("admin.uploadFailed"))
    } finally {
      setUploading(false)
    }
  }

  return (
    <div className="flex flex-col gap-6">
      <div className="grid gap-4 md:grid-cols-3">
        <div className="rounded-xl border bg-card text-card-foreground shadow p-6">
          <h3 className="tracking-tight text-sm font-medium mb-2">{t("admin.neo4jStatus")}</h3>
          <div className="text-2xl font-bold flex items-center gap-2">
            <span className={`w-3 h-3 rounded-full ${data.neo4j_status === 'healthy' ? 'bg-green-500' : 'bg-red-500'}`}></span>
            {data.neo4j_status.toUpperCase()}
          </div>
        </div>
        <div className="rounded-xl border bg-card text-card-foreground shadow p-6">
          <h3 className="tracking-tight text-sm font-medium mb-2">{t("admin.totalNodes")}</h3>
          <div className="text-2xl font-bold">{data.total_nodes ?? 0}</div>
        </div>
        <div className="rounded-xl border bg-card text-card-foreground shadow p-6">
          <h3 className="tracking-tight text-sm font-medium mb-2">{t("admin.totalRelationships")}</h3>
          <div className="text-2xl font-bold">{data.total_relationships ?? 0}</div>
        </div>
      </div>

      <div className="rounded-xl border bg-card text-card-foreground shadow p-6">
        <h3 className="font-semibold leading-none tracking-tight mb-4">{t("admin.uploadTitle")}</h3>
        <p className="text-sm text-muted-foreground mb-4">
          {t("admin.uploadDesc")}
        </p>
        <div className="flex items-center gap-4 max-w-md">
          <Input 
            type="file" 
            onChange={(e) => setFile(e.target.files?.[0] || null)} 
          />
          <Button onClick={handleUpload} disabled={!file || uploading}>
            {uploading ? t("admin.uploadingBtn") : t("admin.uploadBtn")}
          </Button>
        </div>
      </div>

      <GraphViewer />
    </div>
  )
}

function GraphViewer() {
  const { t } = useTranslation()
  const [cypher, setCypher] = useState("MATCH (n) RETURN n LIMIT 50")
  
  const { resolvedTheme } = useTheme()
  const isDark = resolvedTheme === "dark"

  const cypherMutation = useMutation({
    mutationFn: (query: string) => KnowledgeService.executeCypher({ requestBody: { query } }),
    onSuccess: () => {
      toast.success(t("admin.querySuccess") || "Query executed successfully")
    },
    onError: (error) => {
      toast.error(error.message)
    }
  })

  const { data: graphData, isLoading: isLoadingGraph } = useQuery({
    queryKey: ["neo4j-graph-data"],
    queryFn: () => KnowledgeService.getGraphData({ limit: 300 }),
  })

  const runCypher = () => {
    if (!cypher.trim()) return
    cypherMutation.mutate(cypher)
  }

  // format graph data for ForceGraph2D
  const formattedGraphData = {
    nodes: graphData?.nodes?.map(n => {
      const labelName = n.properties?.name || n.properties?.title || n.labels?.[0] || 'Node';
      return { ...n, id: n.id, val: 5, name: labelName }
    }) || [],
    links: graphData?.links?.map(l => ({ ...l, source: l.source, target: l.target, name: l.type })) || []
  }

  const containerRef = useRef<HTMLDivElement>(null)
  const [dimensions, setDimensions] = useState({ width: 800, height: 600 })

  useEffect(() => {
    if (containerRef.current) {
      setDimensions({
        width: containerRef.current.clientWidth,
        height: containerRef.current.clientHeight
      })
    }
    const handleResize = () => {
      if (containerRef.current) {
        setDimensions({
          width: containerRef.current.clientWidth,
          height: containerRef.current.clientHeight
        })
      }
    }
    window.addEventListener('resize', handleResize)
    return () => window.removeEventListener('resize', handleResize)
  }, [])

  return (
    <div className="rounded-xl border bg-card text-card-foreground shadow overflow-hidden flex flex-col mb-8">
      <div className="p-6 border-b flex items-center justify-between bg-muted/20">
        <div>
          <h3 className="font-semibold leading-none tracking-tight mb-2">{t("admin.neo4jBrowserTitle")}</h3>
          <p className="text-sm text-muted-foreground">
            {t("admin.neo4jBrowserDesc")}
          </p>
        </div>
      </div>
      
      <Tabs defaultValue="graph" className="w-full">
        <div className="px-6 pt-4">
          <TabsList>
            <TabsTrigger value="graph" className="flex items-center gap-2">
              <Database className="w-4 h-4" /> Graph View
            </TabsTrigger>
            <TabsTrigger value="cypher" className="flex items-center gap-2">
              <TableIcon className="w-4 h-4" /> Cypher Query
            </TabsTrigger>
          </TabsList>
        </div>
        
        <TabsContent value="graph" className="p-0 m-0 mt-4 outline-none">
          <div ref={containerRef} className={`w-full h-[600px] relative flex items-center justify-center ${isDark ? 'bg-[#0b0c10]' : 'bg-slate-50'}`}>
            {isLoadingGraph ? (
              <div className="text-muted-foreground">Loading graph...</div>
            ) : (
              <ForceGraph2D
                graphData={formattedGraphData}
                nodeLabel={(node: any) => `${node.name}\n${JSON.stringify(node.properties, null, 2)}`}
                linkLabel={(link: any) => link.name}
                nodeAutoColorBy="name"
                nodeRelSize={6}
                linkColor={() => isDark ? 'rgba(255,255,255,0.2)' : 'rgba(0,0,0,0.2)'}
                linkDirectionalArrowLength={3.5}
                linkDirectionalArrowRelPos={1}
                width={dimensions.width}
                height={dimensions.height}
                nodeCanvasObjectMode={() => 'after'}
                nodeCanvasObject={(node: any, ctx, globalScale) => {
                  const label = node.name;
                  const fontSize = 12 / globalScale;
                  ctx.font = `${fontSize}px Sans-Serif`;
                  ctx.textAlign = 'center';
                  ctx.textBaseline = 'middle';
                  ctx.fillStyle = isDark ? 'rgba(255, 255, 255, 0.8)' : 'rgba(0, 0, 0, 0.8)';
                  ctx.fillText(label, node.x, node.y + 12);
                }}
              />
            )}
          </div>
        </TabsContent>
        
        <TabsContent value="cypher" className="p-6 m-0 outline-none flex flex-col gap-4">
          <div className="flex flex-col gap-2">
            <Textarea 
              value={cypher}
              onChange={(e) => setCypher(e.target.value)}
              className="font-mono bg-muted/50 min-h-[100px]"
              placeholder="MATCH (n) RETURN n LIMIT 10"
            />
            <div className="flex justify-end">
              <Button onClick={runCypher} disabled={cypherMutation.isPending} className="flex items-center gap-2">
                <Play className="w-4 h-4" />
                Run Query
              </Button>
            </div>
          </div>
          
          <div className="border rounded-md overflow-x-auto min-h-[300px]">
            {cypherMutation.data && (
              <table className="w-full text-sm text-left">
                <thead className="text-xs uppercase bg-muted">
                  <tr>
                    {cypherMutation.data.columns?.map((col, i) => (
                      <th key={i} className="px-4 py-3">{col}</th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {cypherMutation.data.data?.map((row, i) => (
                    <tr key={i} className="border-b hover:bg-muted/50">
                      {cypherMutation.data.columns?.map((col, j) => (
                        <td key={j} className="px-4 py-3 max-w-xs truncate" title={typeof row[col] === 'object' ? JSON.stringify(row[col]) : String(row[col])}>
                          {typeof row[col] === 'object' ? JSON.stringify(row[col]) : String(row[col])}
                        </td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            )}
            {!cypherMutation.data && !cypherMutation.isPending && (
              <div className="flex items-center justify-center h-[300px] text-muted-foreground">
                Run a query to see results
              </div>
            )}
            {cypherMutation.isPending && (
              <div className="flex items-center justify-center h-[300px] text-muted-foreground">
                Executing...
              </div>
            )}
          </div>
        </TabsContent>
      </Tabs>
    </div>
  )
}

function AdminKnowledge() {
  const { t } = useTranslation()

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">{t("admin.knowledgeBase")}</h1>
        <p className="text-muted-foreground">{t("admin.knowledgeDesc")}</p>
      </div>
      <Suspense fallback={<div>{t("admin.loadingNeo4j")}</div>}>
        <KnowledgeContent />
      </Suspense>
    </div>
  )
}
