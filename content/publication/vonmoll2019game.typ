#let pub = yaml("/yaml/vonmoll2019game.yaml")
#import "/typ/templates/blog.typ": *

#let title = plain-text(pub.title)

#let authors = ()
#for a in pub.author_list {
  authors.push(plain-text([#a.given.at(0). #a.family]))
}
#let authors = authors.join(", ", last: ", and ")
#let authors = plain-text(authors)
#let author = authors

#let venue = ""
#let tags = ()

#if pub.type == "conferencePaper" {
  venue = plain-text(pub.conferenceName)
  tags.push("Conference")
} else if pub.type == "article" or pub.type == "journal" {
  if "journal" in pub {
    venue = plain-text(pub.journal)
  } else {
    venue = plain-text(pub.publicationTitle)
  }
  tags.push("Journal")
} else if pub.type == "misc" {
  venue = plain-text(pub.eventtitle)
  tags.push("Presentation")
} else if pub.type == "thesis" {
  venue = plain-text(pub.university)
  tags.push("Academic")
} else if pub.type == "techreport" {
  venue = plain-text(pub.publicationTitle)
  tags.push("WhitePaper")
}

#let note = none
#if "note" in pub {
  note = [ (#pub.note)]
} else if "annotation" in pub {
  note = [ (#pub.annotation)]
}
#let venue = [#venue#note]
#let date = plain-text(pub.date)
#let file = if "url" in pub { pub.url } else { none } 
#let doi = if "doi" in pub { pub.doi } else { none }

#show: main.with(
  title: title,
  // desc: [This is a test post.],
  date: date,
  tags: tags,
  show-outline: false,
  author: author,
  venue: venue,
  file: file,
  doi: doi,
)

#author

#if pub.type != "thesis" [Published in] else [Institution:] #emph[#venue], #pub.year

#pub.abstractNote

#if "url" in pub [
#link(pub.url)[Download publication]
]

#if "doi" in pub [
DOI: #link("https://doi.org/" + plain-text(pub.doi))[#pub.doi]
]


