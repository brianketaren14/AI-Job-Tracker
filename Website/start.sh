#!/bin/bash
# Start script untuk Railway
# Railway mencari script ini untuk menjalankan aplikasi

set -e

# Print environment info
echo "=========================================="
echo "JobRadar Application Starting"
echo "=========================================="
echo "Python version: $(python --version)"
echo "Node version: $(node --version 2>/dev/null || echo 'Not installed')"
echo "Port: $PORT"
echo "Environment: $FLASK_ENV"
echo "=========================================="
echo ""

# Check if dependencies installed
echo "Checking dependencies..."
python -c "import flask; print('✓ Flask OK')"
python -c "import gunicorn; print('✓ Gunicorn OK')"
python -c "import supabase; print('✓ Supabase OK')"
python -c "import apscheduler; print('✓ APScheduler OK')"
echo ""

# Run gunicorn
echo "Starting Gunicorn..."
exec gunicorn -w 1 \
  -b 0.0.0.0:${PORT:-8000} \
  --timeout 120 \
  --access-logfile - \
  --error-logfile - \
  --log-level info \
  app:app
