# 氧MDUI主题（智简魔方财务系统绝版主题）- 维护版

原作者已停止维护，现由 **云白** 接手维护与修复。

---

## 📌 仓库目录结构

```text
.
├── clientarea/        # 用户中心主题目录（文件夹名：yang-mdui-re）
└── cart/              # 购物车主题目录（文件夹名：yang-mdui-re-cart）
```

---

## 🛠️ 维护与修复更新日志

### 2026-09-21 安全中心界面重构
- 安全中心统一为个人中心风格的 MDUI 白色全宽卡片，移除橙色渐变和全局侵入样式。
- 保留密码、手机/邮箱绑定、实名认证、二次验证、登录提醒、第三方绑定、交互授权及全部原有弹窗和条件分支；API 区域维持原来的注释状态。
- 补齐安全中心本地样式、页面脚本及验证码公共脚本；其他共享资源继续沿用仓库现有默认主题依赖。
- 验证码请求按当前弹窗取值，兼容 MDUI 按钮类名变化，支持失败释放与倒计时。
- 按要求未运行功能测试；此更新不包含后台 `/change_email` HTTP 500 的修复。
- 不提供增量补丁包，可直接下载仓库完整源码。

### v1.0.1 (云白维护更新)
- **修复全局背景透明度 Bug**：修复在魔方后台配置 `yangmdui_bodybg` 背景壁纸后，左侧抽屉式侧边栏（`#left-drawer`）因缺少独立背景声明而变为透明的问题；统一调整为干净纯白（`#ffffff`），并完美向下兼容暗色模式（`#424242`）。
- **字段文档标准化整理**：完整梳理并逆向提取出主题所有隐藏自定义字段与配置方法，方便魔方站长开箱即用。

---

## ⚙️ 主题自定义字段添加与配置方法

### 1. 添加方法说明
智简魔方的主题自定义字段通常在：
**【后台管理】 -> 【系统设置】 -> 【主题设置】（或模板自定义字段/数据库 `zjmf_customfields`）** 中进行维护。
在模板中，字段统一通过 `$CustomDepot.<字段变量名>` 调用。

---

### 2. 用户中心 (`clientarea`) 自定义字段列表

| 变量名 (字段名称) | 类型 | 说明 / 默认值 |
| :--- | :--- | :--- |
| `yangmdui_clientname` | 文本 | 用户中心名称（替换全站平台名称，例如：`云白主机用户中心`） |
| `yangmdui_teamname` | 文本 | 团队/组织名称（用于多平台不互通提示） |
| `yangmdui_color_primary` | 文本 | MDUI 主色调（默认 `indigo`，可选 `red`, `blue`, `pink` 等；若填 `yangmdui` 则启用自定义色） |
| `yangmdui_color_primary_custom` | 文本 | 自定义主色 HEX 代码（如 `#1e88e5`，需配合上一项为 `yangmdui`） |
| `yangmdui_color_accent` | 文本 | MDUI 强调色（默认 `indigo`） |
| `yangmdui_color_accent_custom` | 文本 | 自定义强调色 HEX 代码 |
| `yangmdui_card_radius` | 文本 | 卡片圆角大小（例如 `12px`、`8px`） |
| `yangmdui_btn_radius` | 文本 | 按钮圆角大小（例如 `6px`） |
| `yangmdui_btn_icon_radius` | 文本 | 图标按钮圆角大小（例如 `50%` 或 `8px`） |
| `yangmdui_drawer_class` | 文本 | 侧边栏抽屉附加 CSS 类名 |
| `yangmdui_bodybg` | 文本 | 全站页面背景图 URL 直链 |
| `yangmdui_enable_darkview` | 文本 | 是否启用深色模式切换按钮（填 `"true"` 开启） |
| `yangmdui_custom_logout_sidebar`| 文本 | 是否在侧栏单独显示退出按钮（填 `"true"` 显示） |
| `yangmdui_bootstrap_support` | 文本 | 是否启用 Bootstrap 兼容层（填 `"true"` 开启） |
| `yangmdui_clientarea_notice_enable` | 文本 | 是否开启进站弹窗公告（填 `"true"` 开启） |
| `yangmdui_clientarea_notice_title` | 文本 | 进站弹窗标题（默认 `欢迎回来`） |
| `yangmdui_clientarea_notice_content` | 文本 | 进站弹窗正文公告内容 |
| `yangmdui_clientarea_notice_allowignore` | 文本 | 是否允许用户勾选“下次不再提示”（填 `"true"` 开启） |
| `yangmdui_document_url` | 文本 | 帮助文档中心跳转链接（留空默认 `/knowledgebase`） |
| `yangmdui_qqgroup_number` | 文本 | 官方 QQ 交流群号 |
| `yangmdui_qqgroup_url` | 文本 | 官方 QQ 快速一键加群链接 |
| `yangmdui_billing_payee` | 文本 | 账单收款方名称（展示于账单详情页） |
| `yangmdui_billing_payment` | 文本 | 账单交易服务商名称（展示于账单详情页） |
| `yangmdui_welcomecard` | 文本 | 是否开启新人引导与新人优惠卡片（填 `"true"` 开启） |
| `yangmdui_wcc_displaypro` | 文本 | 是否在新人卡片展示优惠码（填非空值显示） |
| `yangmdui_wcc_prodesc` | 文本 | 优惠码说明（如 `9折`） |
| `yangmdui_wcc_procontent` | 文本 | 优惠券兑换码（如 `NEWUSER`） |
| `yangmdui_wcc_desc` | 文本 | 新人优惠说明详细描述 |
| `yangmdui_wcc_smdesc` | 文本 | 新人优惠小字附注 |
| `yangmdui_afftable` | 文本 | 是否在首页显示推介收益统计表（填 `"true"` 开启） |
| `yang_aff_rank_addid` | 文本 | 推介排行榜附加 ID |
| `yangmdui_footermsg` | 文本/HTML | 页脚自定义文本或备案号 HTML |
| `yangmdui_hidecopy` | 文本 | 是否隐藏版权信息（填 `"true"` 隐藏） |
| `yangmdui_enable_hitokoto` | 文本 | 是否在页脚开启一言功能（填 `"true"` 开启） |
| `yangmdui_hitokoto_serviceurl` | 文本 | 一言 API 接口 URL（默认 `https://v1.hitokoto.cn/`） |
| `yangmdui_clientnat` | 文本 | 是否开启 NAT 端口获取展示（填 `"true"` 开启） |
| `yangmdui_clientnat_fetch` | 文本 | 获取 NAT 映射端口的接口地址 |
| `yangmdui_hideteststatus` | 文本 | 是否隐藏测试状态标识（填 `"true"` 隐藏） |

---

### 3. 购物车 (`cart`) 自定义字段列表

| 变量名 (字段名称) | 类型 | 说明 / 默认值 |
| :--- | :--- | :--- |
| `yangmdui_cart_notice_enable` | 文本 | 是否开启购物车弹窗公告（填 `"true"` 开启） |
| `yangmdui_cart_notice_title` | 文本 | 购物车弹窗标题 |
| `yangmdui_cart_notice_content` | 文本 | 购物车弹窗内容 |
| `yangmdui_cart_notice_allowignore` | 文本 | 购物车弹窗是否允许忽略（填 `"true"`） |
| `yangmdui_cart_stock` | 文本 | 购物车库存控制开关 |
| `yangmdui_stock_showdetails` | 文本 | 是否显示具体库存剩余数值 |
| `yangmdui_logout_hide_price` | 文本 | 未登录用户是否隐藏商品价格（填 `"true"` 隐藏） |
| `yangmdui_show_bates` | 文本 | 是否展示优惠折扣提示 |
| `yangmdui_show_productinfo_batesonly` | 文本 | 是否仅展示折扣信息 |
| `yangmdui_show_trialprice` | 文本 | 是否展示试用价格 |
| `yangmdui_show_trialprice_non` | 文本 | 无试用时展示策略 |

---

## 📦 安装与部署方式

1. 下载仓库代码或 Release 压缩包；
2. 将 `clientarea/` 目录上传至魔方系统的 `/public/themes/clientarea/yang-mdui-re`；
3. 将 `cart/` 目录上传至魔方系统的 `/public/themes/cart/yang-mdui-re-cart`；
4. 进入智简魔方后台 -> **常规设置** -> 分别启用 **用户中心模板** 与 **购物车模板** 即可。
