#' 对数据进行标准化处理
#'
#' 这个函数会对数据框中的数值列进行标准化处理。
#'
#' @param df 一个数据框
#' @return 一个数值列被标准化处理后的数据框
#' @export
standardize <- function(df) {
  numeric_cols <- sapply(df, is.numeric)
  df[numeric_cols] <- lapply(df[numeric_cols], scale)
  df
}
