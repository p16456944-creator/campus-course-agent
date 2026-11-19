#!/bin/sh
# 后台启动 MCP 服务
python mcp_server.py &

# 前台启动 FastAPI
uvicorn app.main:app --host 0.0.0.0 --port 8000