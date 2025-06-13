# Week 01: R语言基础统计作业
# 学生姓名：[请填写您的姓名]
# 学号：[请填写您的学号]
# 完成日期：[请填写完成日期]

# 加载必要的包
library(ggplot2)
library(moments)  # 用于计算偏度和峰度

# 任务1：描述性统计 (25分)
# 实现函数计算描述性统计量
calculate_descriptive_stats <- function(data) {
  # TODO: 实现描述性统计计算
  # 提示：使用 mean(), median(), sd(), quantile(), min(), max()
  
  # 您的代码开始
  
  
  # 您的代码结束
  
  # 返回一个包含所有统计量的列表
  result <- list(
    mean = NA,        # 均值
    median = NA,      # 中位数
    sd = NA,          # 标准差
    q1 = NA,          # 第一四分位数
    q3 = NA,          # 第三四分位数
    min = NA,         # 最小值
    max = NA          # 最大值
  )
  
  return(result)
}

# 任务2：数据分布分析 (25分)
# 分析数据分布特征
analyze_distribution <- function(data) {
  # TODO: 实现分布分析
  # 提示：使用 shapiro.test(), skewness(), kurtosis()
  
  # 您的代码开始
  
  
  # 您的代码结束
  
  # 返回分析结果
  result <- list(
    shapiro_p_value = NA,    # Shapiro-Wilk检验p值
    is_normal = NA,          # 是否符合正态分布 (p > 0.05)
    skewness = NA,           # 偏度
    kurtosis = NA            # 峰度
  )
  
  return(result)
}

# 任务3：假设检验 (25分)
# 进行独立样本t检验
perform_t_test <- function(sample1, sample2) {
  # TODO: 实现t检验
  # 提示：使用 t.test()
  
  # 您的代码开始
  
  
  # 您的代码结束
  
  # 返回检验结果
  result <- list(
    t_statistic = NA,        # t统计量
    p_value = NA,            # p值
    conf_int_lower = NA,     # 置信区间下限
    conf_int_upper = NA,     # 置信区间上限
    conclusion = ""          # 检验结论 ("拒绝原假设" 或 "不拒绝原假设")
  )
  
  return(result)
}

# 任务4：数据可视化 (25分)
# 创建数据摘要图表
create_summary_plot <- function(data, filename = "summary_plot.png") {
  # TODO: 创建箱线图
  # 提示：使用 ggplot2 创建美观的图表
  
  # 您的代码开始
  
  
  # 您的代码结束
  
  # 保存图表
  # ggsave(filename, plot = your_plot, width = 8, height = 6, dpi = 300)
  
  return(TRUE)  # 成功创建图表返回TRUE
}

# ===== 以下为测试代码，请不要修改 =====
# 这些代码用于验证您的函数是否正确实现

if (FALSE) {  # 设置为 TRUE 来运行测试
  # 生成测试数据
  set.seed(123)
  test_data1 <- rnorm(100, mean = 50, sd = 10)  # 正态分布
  test_data2 <- rexp(80, rate = 0.1)            # 指数分布
  sample_a <- rnorm(30, mean = 100, sd = 15)
  sample_b <- rnorm(35, mean = 105, sd = 12)
  
  # 测试函数
  print("测试描述性统计：")
  desc_stats <- calculate_descriptive_stats(test_data1)
  print(desc_stats)
  
  print("测试分布分析：")
  dist_analysis <- analyze_distribution(test_data1)
  print(dist_analysis)
  
  print("测试t检验：")
  t_test_result <- perform_t_test(sample_a, sample_b)
  print(t_test_result)
  
  print("测试可视化：")
  plot_success <- create_summary_plot(test_data1)
  print(paste("图表创建：", ifelse(plot_success, "成功", "失败")))
}