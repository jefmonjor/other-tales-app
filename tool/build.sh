#!/bin/bash

echo "🚀 Iniciando Build de Flutter en Vercel..."

# 1. Instalar Flutter
if [ -d "flutter" ]; then
    echo "✅ Flutter ya está instalado."
else
    echo "⬇️ Clonando Flutter stable..."
    git clone https://github.com/flutter/flutter.git -b stable
fi

# 2. Configurar PATH
export PATH="$PATH:`pwd`/flutter/bin"

# 3. Diagnóstico y Configuración Web
echo "🛠️ Configurando entorno..."
flutter config --enable-web
flutter pub get

# 4. Compilar (Release)
# Vercel inyectará las variables de entorno automáticamente aquí
echo "🏗️ Compilando para Web..."
flutter build web --release --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY --dart-define=API_BASE_URL=https://other-tales-api-706057343259.us-central1.run.app/api/v1

echo "✅ Build completado. Salida en build/web"
