#!/bin/bash

APP_NAME="okenia_crm"
BUILD_DIR="build/macos/Build/Products/Release"
DIST_DIR="dist"
APP_PATH="$BUILD_DIR/$APP_NAME.app"
DMG_PATH="$DIST_DIR/$APP_NAME.dmg"

ICON_PATH="assets/macos/icon.icns"   # опционально
BG_PATH="assets/macos/bg.png"        # опционально

# Очистка и подготовка
rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"
cp -R "$APP_PATH" "$DIST_DIR/"

# Проверка установки create-dmg
if ! command -v create-dmg &> /dev/null; then
    echo "❌ Утилита create-dmg не найдена. Установите через: brew install create-dmg"
    exit 1
fi

# Сборка DMG
create-dmg \
  --volname "$APP_NAME" \
  --volicon "$ICON_PATH" \
  --background "$BG_PATH" \
  --window-pos 200 120 \
  --window-size 500 300 \
  --icon-size 100 \
  --icon "$APP_NAME.app" 100 100 \
  --app-drop-link 380 100 \
  "$DMG_PATH" \
  "$DIST_DIR/"

echo "✅ Готово: $DMG_PATH"
