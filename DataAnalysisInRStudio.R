get()
getwd()
setwd("Desktop/")
list.files()
vec1 = 1:100
class(vec1)

vec2 = c(1.4, 1.2, 2.3)
vec2
class(vec2)
vec2 = as.character(vec2)
vec3 = c("a", "b")
vec3

vec3 = c("1", "2")
vec3

vec4 = c(rep("a", 3), rep("b", 3))
vec4
vec4 = as.factor(vec4)
vec4

vec1 = 1:100
vec2 = 2:101
vec1 + vec2
vec1 * vec2
2^vec1

vec5 = c(rep("a", 5), rep("b", 5))
vec6 = rep("z", 10)

length(vec5)
length(vec5) == length(vec6)

vec = c(T, F, T, F)
vec
class(vec)
if(length(vec5) == length(vec6)){
  o = paste(vec5, vec6)
}