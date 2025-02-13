import { serve } from "https://deno.land/std@0.170.0/http/server.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";
import { config } from "https://deno.land/x/dotenv@v3.2.2/mod.ts";

const env = config({
  path: "D:/Develop/Flutter/Project/my_movie/supabase/functions/vector-sync/.env",
});

const supabase = createClient(
  env.SUPABASE_URL,
  env.SUPABASE_SERVICE_ROLE_KEY,
);

const OPEN_AI_API_KEY = env.OPEN_AI_API_KEY;
const OPEN_AI_API_URL = "https://api.openai.com/v1/embeddings";

serve(async (req) => {
  try {
    // Fetch all films
    const { data: films, error: fetchError } = await supabase
      .from("films")
      .select("*")
      .is("embedding", null);;

    if (fetchError) throw fetchError;

    // Generate embeddings for each film
    const updatedFilms = await Promise.all(films.map(async (film: any) => ({
      ...film,
      embedding: await generateEmbedding(film),
    })));

    // Update films with embeddings
    const { error: updateError } = await supabase
      .from("films")
      .upsert(updatedFilms, { onConflict: "id" });

    if (updateError) throw updateError;

    return new Response(
      JSON.stringify({ success: true, updated: updatedFilms.length }),
      {
        headers: {
          "Content-Type": "application/json",
        },
      },
    );
  } catch (error) {
    return new Response(JSON.stringify({ error: error }), { status: 500 });
  }
});

// Function to generate embeddings using OpenAI API
async function generateEmbedding(film: any): Promise<string> {
  const response = await fetch(OPEN_AI_API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${OPEN_AI_API_KEY}`,
    },
    body: JSON.stringify({
      model: "text-embedding-ada-002",
      input: film.overview || film.title || "",
    }),
  });

  const data = await response.json();

  if (data.error) {
    throw new Error(data.error.message);
  }

  return JSON.stringify(data.data[0].embedding);
}

