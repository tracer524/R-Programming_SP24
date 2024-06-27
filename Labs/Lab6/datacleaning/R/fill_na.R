#' 用指定值填充NA
#'
#' 这个函数会用指定的值填充数据框中的NA。
#'
#' @param df 一个数据框
#' @param value 用来填充NA的值
#' @return 一个NA被填充后的数据框
#' @export
fill_na <- function(df, value) {
  df[is.na(df)] <- value
  df
}
