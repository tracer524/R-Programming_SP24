#' 移除数据框中的NA值
#'
#' 这个函数会移除数据框中的所有包含NA的行。
#'
#' @param df 一个数据框
#' @return 一个不包含NA的行的数据框
#' @importFrom stats complete.cases
#' @export
remove_na <- function(df) {
  df[complete.cases(df), ]
}
