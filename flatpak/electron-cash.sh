#!/bin/bash
PY_VER=$(python3 -c 'import sys; print(f"python{sys.version_info.major}.{sys.version_info.minor}")')
export LD_LIBRARY_PATH=/app/lib:/app/lib/${PY_VER}/site-packages/electroncash/tor/bin:${LD_LIBRARY_PATH}
exec /app/bin/electron-cash.real "$@"
