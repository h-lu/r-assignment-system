# R语言基础统计作业测试文件
# 此文件用于自动批改学生作业

library(testthat)

# 设置测试数据
set.seed(42)
test_data_normal <- rnorm(100, mean = 50, sd = 10)
test_data_exp <- rexp(80, rate = 0.1)
sample_group_a <- rnorm(30, mean = 100, sd = 15)
sample_group_b <- rnorm(35, mean = 105, sd = 12)

# 尝试加载学生代码
tryCatch({
  source("assignment.R")
}, error = function(e) {
  cat("错误：无法加载 assignment.R 文件\n")
  cat("错误信息：", e$message, "\n")
  quit(status = 1)
})

cat("=== R语言基础统计作业自动测试 ===\n")

# 测试结果记录
test_results <- list()
total_score <- 0

# 测试1：描述性统计函数
cat("\n1. 测试描述性统计函数...\n")
tryCatch({
  result <- calculate_descriptive_stats(test_data_normal)
  
  # 检查返回值结构
  if (is.list(result) && all(c("mean", "median", "sd", "q1", "q3", "min", "max") %in% names(result))) {
    # 检查计算准确性
    correct_mean <- abs(result$mean - mean(test_data_normal)) < 1e-6
    correct_median <- abs(result$median - median(test_data_normal)) < 1e-6
    correct_sd <- abs(result$sd - sd(test_data_normal)) < 1e-6
    correct_q1 <- abs(result$q1 - quantile(test_data_normal, 0.25)) < 1e-6
    correct_q3 <- abs(result$q3 - quantile(test_data_normal, 0.75)) < 1e-6
    correct_min <- abs(result$min - min(test_data_normal)) < 1e-6
    correct_max <- abs(result$max - max(test_data_normal)) < 1e-6
    
    if (all(c(correct_mean, correct_median, correct_sd, correct_q1, correct_q3, correct_min, correct_max))) {
      cat("✅ 描述性统计: 通过 (25/25分)\n")
      total_score <- total_score + 25
      test_results$descriptive <- "通过"
    } else {
      cat("❌ 描述性统计: 计算结果不正确 (10/25分)\n")
      total_score <- total_score + 10
      test_results$descriptive <- "部分通过"
    }
  } else {
    cat("❌ 描述性统计: 返回值格式错误 (5/25分)\n")
    total_score <- total_score + 5
    test_results$descriptive <- "格式错误"
  }
}, error = function(e) {
  cat("❌ 描述性统计: 函数执行出错 (0/25分)\n")
  cat("错误信息:", e$message, "\n")
  test_results$descriptive <- paste("错误:", e$message)
})

# 测试2：分布分析函数
cat("\n2. 测试分布分析函数...\n")
tryCatch({
  result <- analyze_distribution(test_data_normal)
  
  if (is.list(result) && all(c("shapiro_p_value", "is_normal", "skewness", "kurtosis") %in% names(result))) {
    # 检查Shapiro-Wilk检验
    shapiro_result <- shapiro.test(test_data_normal)
    correct_shapiro <- abs(result$shapiro_p_value - shapiro_result$p.value) < 1e-6
    correct_is_normal <- result$is_normal == (shapiro_result$p.value > 0.05)
    
    # 检查偏度和峰度
    if (requireNamespace("moments", quietly = TRUE)) {
      correct_skewness <- abs(result$skewness - moments::skewness(test_data_normal)) < 1e-6
      correct_kurtosis <- abs(result$kurtosis - moments::kurtosis(test_data_normal)) < 1e-6
    } else {
      correct_skewness <- TRUE
      correct_kurtosis <- TRUE
    }
    
    if (all(c(correct_shapiro, correct_is_normal, correct_skewness, correct_kurtosis))) {
      cat("✅ 分布分析: 通过 (25/25分)\n")
      total_score <- total_score + 25
      test_results$distribution <- "通过"
    } else {
      cat("❌ 分布分析: 计算结果不正确 (10/25分)\n")
      total_score <- total_score + 10
      test_results$distribution <- "部分通过"
    }
  } else {
    cat("❌ 分布分析: 返回值格式错误 (5/25分)\n")
    total_score <- total_score + 5
    test_results$distribution <- "格式错误"
  }
}, error = function(e) {
  cat("❌ 分布分析: 函数执行出错 (0/25分)\n")
  cat("错误信息:", e$message, "\n")
  test_results$distribution <- paste("错误:", e$message)
})

# 测试3：t检验函数
cat("\n3. 测试t检验函数...\n")
tryCatch({
  result <- perform_t_test(sample_group_a, sample_group_b)
  
  if (is.list(result) && all(c("t_statistic", "p_value", "conf_int_lower", "conf_int_upper", "conclusion") %in% names(result))) {
    # 使用R内置t.test验证结果
    t_test_result <- t.test(sample_group_a, sample_group_b)
    
    correct_t <- abs(result$t_statistic - t_test_result$statistic) < 1e-6
    correct_p <- abs(result$p_value - t_test_result$p.value) < 1e-6
    correct_conf_lower <- abs(result$conf_int_lower - t_test_result$conf.int[1]) < 1e-6
    correct_conf_upper <- abs(result$conf_int_upper - t_test_result$conf.int[2]) < 1e-6
    
    expected_conclusion <- ifelse(t_test_result$p.value < 0.05, "拒绝原假设", "不拒绝原假设")
    correct_conclusion <- result$conclusion == expected_conclusion
    
    if (all(c(correct_t, correct_p, correct_conf_lower, correct_conf_upper, correct_conclusion))) {
      cat("✅ 假设检验: 通过 (25/25分)\n")
      total_score <- total_score + 25
      test_results$t_test <- "通过"
    } else {
      cat("❌ 假设检验: 计算结果不正确 (10/25分)\n")
      total_score <- total_score + 10
      test_results$t_test <- "部分通过"
    }
  } else {
    cat("❌ 假设检验: 返回值格式错误 (5/25分)\n")
    total_score <- total_score + 5
    test_results$t_test <- "格式错误"
  }
}, error = function(e) {
  cat("❌ 假设检验: 函数执行出错 (0/25分)\n")
  cat("错误信息:", e$message, "\n")
  test_results$t_test <- paste("错误:", e$message)
})

# 测试4：可视化函数
cat("\n4. 测试可视化函数...\n")
tryCatch({
  result <- create_summary_plot(test_data_normal, "test_plot.png")
  
  if (result == TRUE && file.exists("test_plot.png")) {
    cat("✅ 数据可视化: 通过 (25/25分)\n")
    total_score <- total_score + 25
    test_results$visualization <- "通过"
    # 清理测试文件
    file.remove("test_plot.png")
  } else {
    cat("❌ 数据可视化: 未生成图片文件 (10/25分)\n")
    total_score <- total_score + 10
    test_results$visualization <- "部分通过"
  }
}, error = function(e) {
  cat("❌ 数据可视化: 函数执行出错 (0/25分)\n")
  cat("错误信息:", e$message, "\n")
  test_results$visualization <- paste("错误:", e$message)
})

# 输出最终结果
cat("\n=== 测试总结 ===\n")
cat(sprintf("通过测试: %d/4\n", sum(sapply(test_results, function(x) x == "通过"))))
cat(sprintf("总分: %d/100\n", total_score))

# 根据分数给出评价
if (total_score >= 90) {
  cat("🎉 优秀！您的作业完成得非常好！\n")
} else if (total_score >= 80) {
  cat("👍 良好！作业基本完成，还有改进空间。\n")
} else if (total_score >= 60) {
  cat("📝 及格。请继续努力提高代码质量。\n")
} else {
  cat("❌ 需要改进。请仔细检查代码并重新提交。\n")
}

# 退出并返回状态码
quit(status = ifelse(total_score >= 60, 0, 1))