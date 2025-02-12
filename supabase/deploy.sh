
# Install supabase files locally
rm -rf supabase
npm install supabase --save-dev
npx supabase init

# Override default values with custom config.toml
cp config.toml  supabase/config.toml
source .env

# Start supabase containers. ANON_KEY and other details will be displayed in logs.
npx supabase stop
npx supabase start