# 校园课程智能助手

一个基于 AI Agent 的校园课程智能助手。学生可以通过自然语言向助手查询个人课表，Agent 自动调用 MCP 工具获取相关信息，并辅助生成学习计划。

## 项目简介

本项目实现了一个校园课程智能助手，用户可以通过自然语言与 AI Agent 交互。Agent 根据用户请求，自动调用 MCP 工具查询个人课程安排，并提供相应的信息与学习计划辅助。

## 功能介绍

| 模块 | 功能 |
| --- | --- |
| 前端 | 登录、注册、菜单主页、用户管理（管理员）、个人信息、修改密码 |
| 后端 | 登录注册、JWT 身份认证、统一返回格式、全局异常处理、用户 CRUD、文件上传、静态资源挂载 |
| 数据库 | MySQL，支持初始化表结构及演示账号（建议导入 `sql/backend.sql`） |
| AI Agent | 基于 LangChain ReAct Agent，使用自然语言理解用户请求并调用 MCP 工具 |
| MCP 工具服务 | 使用 FastMCP 提供独立工具服务，支持 Agent 调用 |

## 技术栈

| 技术模块 | 使用技术 |
| --- | --- |
| 前端 | Vue 3、Element Plus、Axios、Vite |
| 后端 | Python、FastAPI、SQLAlchemy、JWT |
| Agent 框架 | LangChain（ReAct Agent）、FastMCP（独立进程） |
| 大模型 | DeepSeek API（OpenAI 兼容协议） |
| 数据库 | MySQL 8.0+ |
| 容器化部署 | Podman、podman-compose |

## 项目结构

```text
campus-course-agent/
├── sql/
│   └── backend.sql          # 数据库初始化脚本（自动挂载至容器）
├── backend/                 # FastAPI + Agent 核心逻辑
│   ├── app/                 # 路由与业务逻辑
│   ├── mcp_server.py        # FastMCP 工具服务
│   ├── start.sh             # 容器内启动 FastAPI 和 MCP 的脚本
│   ├── Containerfile        # 后端容器构建文件
│   ├── requirements.txt      # Python 依赖
│   └── .env.example         # 环境变量模板
├── frontend/                # Vue 3 前端项目
│   ├── Containerfile        # 前端容器构建文件（Nginx 部署）
│   └── ...
├── compose.yaml             # Podman 多容器编排文件
└── README.md
```

## 部署与使用

### 1. 配置环境变量

为保护 API Key 安全，项目仓库不包含真实的 `.env` 配置文件。启动前请完成以下配置：

1. 进入 `backend/` 目录。
2. 将 `.env.example` 复制一份，并命名为 `.env`。
3. 打开 `.env` 文件，配置自己的 DeepSeek API Key。

示例：

```env
DEEPSEEK_API_KEY=sk-xxxxxxxxxxxxxxxxx
```

请将示例中的 Key 替换为您自己的真实密钥（或使用项目作业文档中提供的测试 Key，如适用）。

### 2. 启动项目

请确保电脑已安装 **Podman** 和 **podman-compose**。

需要先进入到项目根目录：
```bash
cd campus-course-agent
```

在项目根目录打开终端，执行：

```bash
podman-compose up -d --build
```

该命令将构建镜像并在后台启动项目所需的服务，包括前端、后端、MCP 服务及 MySQL。

### 3. 访问项目

启动完成后，可通过以下地址访问：

| 服务 | 地址 | 说明 |
| --- | --- | --- |
| 前端 | http://localhost:8080 | Web 可视化界面 |
| 后端 API 文档 | http://localhost:8000/docs | Swagger 接口文档 |

## 功能测试

### 方式一：前端可视化 SSE 流式测试（推荐）

1. 在浏览器中打开 [http://localhost:8080](http://localhost:8080)。
2. 使用测试账号登录（默认账号可查看 `sql/backend.sql`，例如 `admin / admin`，具体以脚本为准）。
3. 在聊天框输入请求，例如：

   > 帮我查一下明天的课表

4. 观察聊天窗口中的 Agent 运行过程。

预期效果：聊天框实时显示 Agent 的工具调用状态（例如 `[正在调用 get_my_schedules...]`），随后 AI 回复以流式方式逐步输出。

### 方式二：后端 API 接口测试（Swagger）

1. 在浏览器中打开 [http://localhost:8000/docs](http://localhost:8000/docs)。
2. 找到 `POST /api/chat` 接口，点击 **Try it out**。
3. 输入请求 JSON：

   ```json
   {
     "query": "查我的课表"
   }
   ```

4. 点击 **Execute**。
5. 在下方 **Server response** 中查看 Agent 返回的 JSON 结果。

## 停止项目

在项目根目录的终端中执行：

```bash
podman-compose down
```

该命令会停止并移除由 Compose 管理的容器。数据卷是否一并清除取决于 Compose 配置及所使用的命令。

---

