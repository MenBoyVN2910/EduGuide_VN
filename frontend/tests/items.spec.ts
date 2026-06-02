import { expect, test } from "@playwright/test"
import { createUser } from "./utils/privateApi"
import {
  randomEmail,
  randomItemDescription,
  randomItemTitle,
  randomPassword,
} from "./utils/random"
import { logInUser } from "./utils/user"

test("Items page is accessible and shows correct title", async ({ page }) => {
  await page.goto("/items")
  await expect(page.getByRole("heading", { name: "Notes", exact: true })).toBeVisible()
  await expect(page.getByText("Manage your study materials centrally.")).toBeVisible()
})

test("Add Item button is visible", async ({ page }) => {
  await page.goto("/items")
  await expect(page.getByRole("button", { name: "Create new" })).toBeVisible()
})

test.describe("Items management", () => {
  test.use({ storageState: { cookies: [], origins: [] } })
  let email: string
  const password = randomPassword()

  test.beforeAll(async () => {
    email = randomEmail()
    await createUser({ email, password })
  })

  test.beforeEach(async ({ page }) => {
    await logInUser(page, email, password)
    await page.goto("/items")
  })

  test("Create a new item successfully", async ({ page }) => {
    const title = randomItemTitle()
    const description = randomItemDescription()

    await page.getByRole("button", { name: "Create new" }).click()
    await page.getByLabel("Title").fill(title)
    await page.getByLabel("Content").fill(description)
    await page.getByRole("button", { name: "Save note" }).click()

    await expect(page.getByRole("heading", { name: title })).toBeVisible()
  })

  test("Create item with only required fields", async ({ page }) => {
    const title = randomItemTitle()

    await page.getByRole("button", { name: "Create new" }).click()
    await page.getByLabel("Title").fill(title)
    await page.getByRole("button", { name: "Save note" }).click()

    await expect(page.getByRole("heading", { name: title })).toBeVisible()
  })

  test("Cancel item creation", async ({ page }) => {
    await page.getByRole("button", { name: "Create new" }).click()
    await page.getByLabel("Title").fill("Test Item")
    await page.getByRole("button", { name: "Cancel" }).click()

    await expect(page.getByRole("dialog")).not.toBeVisible()
  })

  test.describe("Edit and Delete", () => {
    let itemTitle: string

    test.beforeEach(async ({ page }) => {
      itemTitle = randomItemTitle()

      await page.getByRole("button", { name: "Create new" }).click()
      await page.getByLabel("Title").fill(itemTitle)
      await page.getByRole("button", { name: "Save note" }).click()
      await expect(page.getByRole("heading", { name: itemTitle })).toBeVisible()
    })

    test("Edit an item successfully", async ({ page }) => {
      await page.getByRole("heading", { name: itemTitle }).first().click()

      const updatedTitle = randomItemTitle()
      await page.getByPlaceholder("Nhập tiêu đề...").fill(updatedTitle)
      await page.getByRole("button", { name: "Lưu thay đổi" }).click()

      await expect(page.getByRole("heading", { name: updatedTitle })).toBeVisible()
    })

    test("Delete an item successfully", async ({ page }) => {
      await page.getByRole("heading", { name: itemTitle }).first().click()

      // Click the trash delete button inside the modal
      await page.getByTestId("delete-note-button").click()

      await expect(page.getByRole("heading", { name: itemTitle })).not.toBeVisible()
    })
  })
})

test.describe("Items empty state", () => {
  test.use({ storageState: { cookies: [], origins: [] } })

  test("Shows empty state message when no items exist", async ({ page }) => {
    const email = randomEmail()
    const password = randomPassword()
    await createUser({ email, password })
    await logInUser(page, email, password)

    await page.goto("/items")

    await expect(page.getByText("No notes yet")).toBeVisible()
    await expect(page.getByText("Start recording interesting knowledge")).toBeVisible()
  })
})
