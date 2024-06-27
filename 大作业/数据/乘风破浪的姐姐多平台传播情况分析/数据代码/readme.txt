这六份数据来源于豆瓣、微博、知乎三个平台

doubancom.xlsx:豆瓣平台短评数据
	ID：评论发布者的用户昵称
	short：评论的文本内容
	votes：该短评的“点赞”数
	time：评论发布时间
	emotion：该评论的情感得分
doubanrp.xlsx:豆瓣平台用户被关注数据
	ID：评论发布者的用户昵称
	time:评论发布时间
	content:评论的文本内容
	agreenum:该短评的“点赞”数
	follower:该评论发布者的被关注数

wbcom.xlsx:微博平台博文数据
	ID：博文发布者的用户昵称
	content：博文的文本内容
	time：博文发布时间
	agree：该博文的“点赞”数
	emotion：该博文的情感得分
wbrp.xlsx:微博平台用户被关注数据
	ID：博文发布者的用户昵称
	agreenum：该博文的“点赞”数
	follower：该博文发布者的被关注数

zhihucom.xlsx:知乎平台回答数据
	ID：回答者的用户昵称
	tag：回答者的个人标签
	agree：该回答的“点赞”数
	time：回答发布时间
	comment：回答的文本内容
	emotion：该回答的情感得分
zhrp.xlsx:知乎平台用户被关注数据
	question:问题内容
	agreenum:该回答的“点赞”数
	content:回答的文本内容
	ID:回答者的用户昵称
	follower:该回答发布者的被关注数

以上6个数据中：
*用于进行三平台意见领袖影响力分析的数据：
doubanrp.xlsx
wbrp.xlsx
zhrp.xlsx

*用于进行话题热度分析、时间序列建模的数据：
doubancom.xlsx
wbcom.xlsx
zhihucom.xlsx

