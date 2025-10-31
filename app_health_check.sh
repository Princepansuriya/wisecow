#!/bin/bash

APP_URL="http://localhost:4499"
STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" $APP_URL)

if [ "$STATUS_CODE" -eq 200 ]; then
  echo "✅ Wisecow Application is UP (Status Code: $STATUS_CODE)"
else
  echo "❌ Wisecow Application is DOWN (Status Code: $STATUS_CODE)"
fi
