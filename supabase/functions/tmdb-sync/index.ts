import { serve } from "https://deno.land/std@0.170.0/http/server.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";
import { config } from "https://deno.land/x/dotenv@v3.2.2/mod.ts";

const env = config({
  path: "C:/Users/Dell/Develop/Flutter/Project/my_movie/.env",
});

const supabase = createClient(
  env.SUPABASE_URL,
  env.SUPABASE_SERVICE_ROLE_KEY,
);

const TMDB_API_KEY = env.TMDB_API_KEY;
const TMDB_URL = "https://api.themoviedb.org/3";

serve(async (req) => {
  try {
    const movies = [];

    for (let page = 1; page <= 100; page++) {
      const response = await fetch(
        `${TMDB_URL}/movie/popular?api_key=${TMDB_API_KEY}&page=${page}`,
      );
      const data = await response.json();

      if (!data.results) break;

      // Transform movies data
      const pageMovies = data.results.map((movie: any) => ({
        id: movie.id,
        title: movie.title || "No title available",
        overview: movie.overview || "No overview available",
        release_date: movie.release_date || null,
        poster_path: movie.poster_path || null,
        backdrop_path: movie.backdrop_path || null,
      }));

      movies.push(...pageMovies);
    }

    const uniqueMovies = Array.from(new Map(movies.map(m => [m.id, m])).values());

    // Insert into Supabase
    // const { error } = await supabase.from("films").upsert(movies);
    const { error } = await supabase.from("films").upsert(uniqueMovies, { onConflict: "id" });

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
