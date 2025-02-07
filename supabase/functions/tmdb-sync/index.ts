import { serve } from "https://deno.land/std@0.170.0/http/server.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";
import { config } from "https://deno.land/x/dotenv@v3.2.2/mod.ts";

const env = config();

const supabase = createClient(
  env.SUPABASE_URL,
  env.SUPABASE_SERVICE_ROLE_KEY
);

const TMDB_API_KEY = env.TMDB_API_KEY;
const TMDB_URL = "https://api.themoviedb.org/3";

serve(async (req) => {
  try {
    const page = new URL(req.url).searchParams.get("page") || "1";
    const response = await fetch(
      `${TMDB_URL}/movie/popular?api_key=${TMDB_API_KEY}&page=${page}`,
    );
    const data = await response.json();

    if (!data.results) return new Response("No movies found", { status: 404 });

    // Transform movies data
    const movies = data.results.map((movie: any) => ({
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      release_date: movie.release_date,
      poster_path: movie.poster_path,
      backdrop_path: "",
    }));

    // Insert into Supabase
    const { error } = await supabase.from("films").upsert(movies);

    if (error) throw error;

    return new Response(
      JSON.stringify({ success: true, inserted: movies.length }),
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
