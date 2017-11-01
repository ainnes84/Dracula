nrc<-get_sentiments('nrc')

nrc_fear<-nrc%>%
  filter(sentiment=='fear')

dracula<-gutenberg_download(345)

dracula_words<-dracula%>%
  unnest_tokens(word,text)

dracula_fear_words<-inner_join(nrc_fear,dracula_words)

fear_df<-dracula_fear_words%>%
  group_by(word)%>%
  summarize(count=n())

wordcloud(fear_df$word,fear_df$count,min.freq = 10)