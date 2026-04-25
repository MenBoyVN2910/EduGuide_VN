import os, re, glob, sys

# Fix encoding for Windows console
sys.stdout = open(sys.stdout.fileno(), mode='w', encoding='utf-8', buffering=1)

CYPHER_DIR = r'd:\DEV_KnowLedge\Done_Project\EduGuide_VN\ChatBoxAI_Educational\About_System\3.All_CypherQuery'

def extract_course_ids(content):
    return re.findall(r"MERGE\s*\(\s*:Course\s*\{[^}]*id:\s*'([^']+)'", content)

def extract_major_id(content):
    m = re.search(r"MERGE\s*\(\s*:Major\s*\{[^}]*id:\s*'([^']+)'", content)
    return m.group(1) if m else None

def fix_belongs_to(content, course_ids, major_id):
    old_pattern = (
        r"MATCH \(c:Course\), \(m:Major \{id: '"
        + re.escape(major_id)
        + r"'\}\)\nMERGE \(c\)-\[:BELONGS_TO\]->\(m\);"
    )
    chunk_size = 8
    id_chunks = []
    for i in range(0, len(course_ids), chunk_size):
        chunk = course_ids[i:i+chunk_size]
        id_chunks.append(", ".join(f"'{cid}'" for cid in chunk))
    ids_formatted = ",\n    ".join(id_chunks)
    new_text = (
        f"MATCH (c:Course), (m:Major {{id: '{major_id}'}})\n"
        f"WHERE c.id IN [\n    {ids_formatted}\n]\n"
        f"MERGE (c)-[:BELONGS_TO]->(m);"
    )
    return re.sub(old_pattern, new_text, content)

files = glob.glob(os.path.join(CYPHER_DIR, "*Cypher*"))
files = list(set(files))
files.sort()
print(f"Found {len(files)} files")

fixed = 0
for fp in files:
    with open(fp, "r", encoding="utf-8") as f:
        content = f.read()
    major_id = extract_major_id(content)
    if not major_id:
        continue
    course_ids = extract_course_ids(content)
    if not course_ids:
        continue
    if "WHERE c.id IN [" in content:
        print(f"  SKIP: {major_id} ({len(course_ids)} courses) - already fixed")
        continue
    new_content = fix_belongs_to(content, course_ids, major_id)
    if new_content == content:
        print(f"  WARN: {major_id} - no match for old pattern")
        continue
    with open(fp, "w", encoding="utf-8") as f:
        f.write(new_content)
    fixed += 1
    print(f"  FIXED: {major_id} - {len(course_ids)} courses")

print(f"\nDone! Fixed {fixed}/{len(files)} files.")
