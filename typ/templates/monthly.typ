#import "shared.typ": *
#let main = shared-template.with(kind: "monthly")

#let articles = json("/content/snapshot/article-ids.json").map(it => ((it): it)).join()
