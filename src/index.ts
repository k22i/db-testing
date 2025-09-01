import { Hono } from "hono";
import { sql } from "bun";
import "dotenv/config";

const app = new Hono();

app.get("/", async (c) => {
  console.log(Bun.env.DATABASE_URL, "!!!!");
  const res = await sql`SELECT 1;`;
  return c.json(res);
});

export default {
  port: 8889,
  fetch: app.fetch,
};
