# Elysia-Cryene

DeepSeek Harness Web GUI 的启动画面与界面美化包。

以 D 盘素材（翻书、背景、角色图）构建的 DSH 前端定制：
**开屏加载动画**（翻书背景 + 加载圆圈 + 进度条 + 标题）与**主界面美化**（背景图、粉色侧边栏、透明对话框）。

## 效果

- **开屏**：翻书加载动画 —— Ken Burns 缓推背景、星光闪烁、加载圆圈（翻书 + 旋转光环）、下方横向进度条、上方中央标题

  `DeepSeek harness` / 副标题 `Elysia-Cryene`
- **主界面**：
  - 纯黑底 → 背景图（`背景.png`，75% 不透明）→ 内容
  - 左侧侧边栏：浅粉 `#FBC8DD` + 蓝紫文字/图标 `#626EB8`
  - 对话框/输入框/我的消息气泡：透明（背景透出）
- 开屏在界面完全就绪（连续 10 帧 + 最短 1.8s）后淡出

## 文件结构

```
Elysia-cyrene/
├── splash-template.html      # 完整前端模板（含 __BOOK_B64__ 占位符）
├── assets/
│   ├── book.jpg              # 开屏素材（翻书）
│   └── background.png        # 主界面背景图
└── scripts/
    └── install.ps1           # 一键部署到 DSH dist
```

## 安装

1. 把 `assets/` 与 `splash-template.html` 放在一起（保持结构）。
2. 运行部署脚本（需指定你的 DSH 前端 dist 目录）：

```powershell
powershell -ExecutionPolicy Bypass -File scripts\install.ps1
# 若 DSH 安装位置不同：
powershell -ExecutionPolicy Bypass -File scripts\install.ps1 -DshDist "你的 dist 路径"
```

3. 重启 DSH web 服务（`dsh web`），刷新页面生效。

> 脚本会：注入模板到 `dist/index.html`（把 `book.jpg` 以 base64 内联替换 `__BOOK_B64__`），并把 `background.png` 复制为 `dist/assets/boot-bg.png`。


##简易安装方法
```text
请帮我下载这个插件：https://github.com/weizhi-notfound/Elysia-cyrene，并检查兼容性等问题。
若出现问题自动修复，仅对该文件包含内容进行修正。
```

## 自定义

- 换开屏图：替换 `assets/book.jpg` 后重跑脚本。
- 换背景图：替换 `assets/background.png` 后重跑脚本。
- 调颜色/透明度：编辑 `splash-template.html` 内联 `<style>`（侧边栏 `#FBC8DD` / 文字 `#626EB8` / 背景 `#dsh-bg` 的 `opacity` 等）。

## 注意

- 模板内含 `__BOOK_B64__` 占位符，必须经 `scripts/install.ps1` 注入后才能直接使用；不要直接上传注入后的 `dist/index.html` 大文件。
- 素材（`book.jpg` / `background.png`）版权归原作者，仅供个人美化使用；商用请自行确认授权。

## License

代码：MIT（见 LICENSE）。素材版权归原作者（mihoyo）。
