# R语言作业自动批阅系统

这是一个基于GitHub工作流的R语言作业系统，支持老师发布作业、学生通过PR提交、自动批改评分。

## 🎯 系统特点

- 📚 老师通过Git仓库发布作业
- 🔄 学生通过Pull Request提交作业
- 🤖 GitHub Actions自动批改和评分
- 📊 自动生成详细的评分报告
- 💬 PR评论中提供即时反馈

## 👨‍🏫 老师使用指南

### 1. 发布新作业

1. 在 `assignments/` 目录下创建新的作业文件夹
2. 添加作业说明文件 `README.md`
3. 创建作业模板文件 `assignment.R`
4. 编写测试用例 `tests.R`
5. 推送到main分支

### 2. 作业结构示例

```
assignments/
├── week01-basic-statistics/
│   ├── README.md          # 作业说明
│   ├── assignment.R       # 作业模板
│   └── tests.R            # 测试用例
└── week02-data-analysis/
    ├── README.md
    ├── assignment.R
    └── tests.R
```

## 👨‍🎓 学生使用指南

### 1. 开始作业

1. **Fork** 这个仓库到您的GitHub账户
2. **Clone** 您fork的仓库到本地
   ```bash
   git clone https://github.com/YOUR_USERNAME/r-assignment-system.git
   cd r-assignment-system
   ```

### 2. 完成作业

1. 进入对应的作业目录
2. 阅读 `README.md` 了解作业要求
3. 编辑 `assignment.R` 完成代码
4. 本地测试您的代码

### 3. 提交作业

1. 提交更改到您的仓库
   ```bash
   git add .
   git commit -m "完成week01作业"
   git push origin main
   ```

2. 在GitHub上创建Pull Request
   - 标题格式：`[学号-姓名] Week01 作业提交`
   - 描述中说明完成情况

### 4. 查看反馈

- 提交PR后，系统会自动运行测试
- 在PR的"Checks"选项卡查看详细测试结果
- 在PR评论中查看评分和反馈

## 🚀 自动批改流程

1. 学生提交PR后触发GitHub Actions
2. 系统运行R代码测试
3. 检查代码语法和逻辑
4. 执行单元测试验证结果
5. 计算总分并生成报告
6. 在PR中自动评论反馈结果

## 📊 评分标准

- **代码正确性** (60%): 测试用例通过情况
- **代码质量** (20%): 代码风格和注释
- **效率** (10%): 算法效率和性能
- **创新性** (10%): 解题思路和优化

## 🛠️ 技术栈

- **语言**: R
- **CI/CD**: GitHub Actions
- **测试框架**: testthat
- **代码检查**: lintr
- **版本控制**: Git/GitHub

## 📋 作业列表

| 作业 | 主题 | 状态 | 截止时间 |
|------|------|------|----------|
| [Week01](assignments/week01-basic-statistics/) | R语言基础统计 | 🟢 可用 | 待定 |
| Week02 | 数据分析 | 🟡 开发中 | 待定 |
| Week03 | 数据可视化 | ⚪ 计划中 | 待定 |

## ❓ 常见问题

### Q: 如何本地测试我的代码？
A: 在作业目录下运行 `Rscript tests.R` 即可本地执行测试。

### Q: PR提交后多久会有结果？
A: 通常在2-5分钟内完成自动批改，复杂作业可能需要更长时间。

### Q: 可以多次提交吗？
A: 可以！每次push到您的fork仓库都会触发重新评测。

### Q: 如何查看详细的错误信息？
A: 在PR页面的"Checks"选项卡中可以查看完整的测试日志。

## 📞 支持

如有问题，请创建Issue或联系助教。

---

祝您学习愉快！🎉