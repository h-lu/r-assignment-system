# Week 01: R语言基础统计作业 - 参考答案
# 此文件仅供教师参考，学生不应查看

# 加载必要的包
library(ggplot2)
library(moments)

# 任务1：描述性统计 (25分)
calculate_descriptive_stats <- function(data) {
  # 处理空数据或异常情况
  if (length(data) == 0) {
    return(list(
      mean = NA, median = NA, sd = NA,
      q1 = NA, q3 = NA, min = NA, max = NA
    ))
  }
  
  # 计算描述性统计量
  mean_val <- mean(data, na.rm = TRUE)
  median_val <- median(data, na.rm = TRUE)
  sd_val <- sd(data, na.rm = TRUE)
  quartiles <- quantile(data, c(0.25, 0.75), na.rm = TRUE)
  min_val <- min(data, na.rm = TRUE)
  max_val <- max(data, na.rm = TRUE)
  
  # 返回结果
  result <- list(
    mean = mean_val,
    median = median_val,
    sd = sd_val,
    q1 = quartiles[1],
    q3 = quartiles[2],
    min = min_val,
    max = max_val
  )
  
  return(result)
}

# 任务2：数据分布分析 (25分)
analyze_distribution <- function(data) {
  # 处理空数据
  if (length(data) < 3) {
    return(list(
      shapiro_p_value = NA,
      is_normal = FALSE,
      skewness = NA,
      kurtosis = NA
    ))
  }
  
  # Shapiro-Wilk正态性检验
  shapiro_result <- shapiro.test(data)
  shapiro_p <- shapiro_result$p.value
  is_normal <- shapiro_p > 0.05
  
  # 计算偏度和峰度
  skew_val <- skewness(data)
  kurt_val <- kurtosis(data)
  
  # 返回结果
  result <- list(
    shapiro_p_value = shapiro_p,
    is_normal = is_normal,
    skewness = skew_val,
    kurtosis = kurt_val
  )
  
  return(result)
}

# 任务3：假设检验 (25分)
perform_t_test <- function(sample1, sample2) {
  # 执行独立样本t检验
  t_result <- t.test(sample1, sample2)
  
  # 提取结果
  t_stat <- as.numeric(t_result$statistic)
  p_val <- t_result$p.value
  conf_int <- t_result$conf.int
  
  # 判断检验结论
  conclusion <- ifelse(p_val < 0.05, "拒绝原假设", "不拒绝原假设")
  
  # 返回结果
  result <- list(
    t_statistic = t_stat,
    p_value = p_val,
    conf_int_lower = conf_int[1],
    conf_int_upper = conf_int[2],
    conclusion = conclusion
  )
  
  return(result)
}

# 任务4：数据可视化 (25分)
create_summary_plot <- function(data, filename = "summary_plot.png") {
  # 创建数据框
  df <- data.frame(values = data)
  
  # 创建箱线图
  p <- ggplot(df, aes(y = values)) +
    geom_boxplot(aes(x = ""), 
                 fill = "lightblue", 
                 color = "darkblue",
                 alpha = 0.7) +
    geom_jitter(aes(x = ""), 
                width = 0.2, 
                alpha = 0.5,
                color = "red") +
    labs(
      title = "数据分布箱线图",
      subtitle = paste("样本量:", length(data)),
      y = "数值",
      x = ""
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
      plot.subtitle = element_text(hjust = 0.5, size = 12),
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank()
    )
  
  # 添加统计信息
  mean_val <- mean(data)
  median_val <- median(data)
  
  p <- p + annotate("text", 
                    x = 1.3, 
                    y = mean_val, 
                    label = paste("均值:", round(mean_val, 2)),
                    hjust = 0) +
    annotate("text", 
             x = 1.3, 
             y = median_val, 
             label = paste("中位数:", round(median_val, 2)),
             hjust = 0)
  
  # 保存图表
  ggsave(filename, plot = p, width = 8, height = 6, dpi = 300)
  
  return(TRUE)
}