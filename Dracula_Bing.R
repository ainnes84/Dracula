bing<-get_sentiments('bing')
dracula<-gutenberg_download(345)

dracula_words<-dracula%>%
  unnest_tokens(word,text)

dracula_bing_words<-inner_join(bing,dracula_words)

dracula_bing_words$gutenberg_id<-NULL

dracula_bing_words$score<-1

rows<-which(dracula_bing_words$sentiment=='negative')

dracula_bing_words$score[rows]<--1