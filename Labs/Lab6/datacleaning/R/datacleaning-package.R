#' 提供了一些基本的数据清洗函数，
#' 包括移除缺失值、填充缺失值以及数据标准化处理。
#'
#' @section 函数列表:
#' \describe{
#'   \item{\code{\link{remove_na}}}{移除数据框中的NA值}
#'   \item{\code{\link{fill_na}}}{用指定值填充NA}
#'   \item{\code{\link{standardize}}}{对数据进行标准化处理}
#' }
#'
#' @section demo functions:
#'
#' library(lab6)
#' df <- data.frame(a = c(1, 2, NA), b = c(4, NA, 6))
#'
#' # 移除缺失值
#' clean_df <- remove_na(df)
#'
#' # 用0填充缺失值
#' filled_df <- fill_na(df, 0)
#'
#' # 标准化数据
#' standardized_df <- standardize(df)
#'
#'
#' @docType package
#' @name datacleaner
NULL
