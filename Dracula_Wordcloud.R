dracula<-gutenberg_download(345)
dracula_words<-dracula%>%
  unnest_tokens(word,text)

bing<-get_sentiments('bing')

dracula_words<-inner_join(dracula_words,bing)

dracula_words$gutenberg_id<-NULL

dracula_words<-dracula_words%>%
  group_by(word)%>%
  summarize(freq=n(),sentiment=first(sentiment))

wordcloud(dracula_words$word,dracula_words$freq,min.freq=10)

wordcloud2(dracula_words,fig='bat.jpg',backgroundColor='black')

dracula_matrix<-acast(dracula_words,word~sentiment,value.var='freq',fill=0)

comparison.cloud(dracula_matrix,colors=c('black', '#ff7433'))