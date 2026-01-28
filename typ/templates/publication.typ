#import "shared.typ": *
#let main = shared-template.with(kind: "post")

#let pub-body(pub: (title: "title", author: "me", venue: "none", date: "2025-09-10")) = {
  // let pub-yaml = (
  //   author: "A. Von Moll",
  //   venue: "AIAA Journal of Aerospace Information Systems",
  //   date: "2025-04-25",
  //   title: "Different"
  // )

  [
  #let title = plain-text(pub.title)
  #let author = plain-text(pub.author)
  #let venue = plain-text(pub.conferenceName)
  #let date = plain-text(pub.date)
#let author = "A. Von Moll"
#let venue = "AIAA Journal of Aerospace Information Systems"
#let date = "2025-04-25"
#let title = "Turret Defense"

  #show: main.with(
    title: title,
    desc: [This is a test post.],
    date: date,
    tags: (
    blog-tags.misc,
    blog-tags.journal,
  ),
    show-outline: false,
    author: author,
    venue: venue,
  )

  test
  
    // #pub.author
    
    // #pub.date

    // #pub.venue

    // #pub.abstractNote

    // #body
  ]
}

// #let pub-body(body) = {
//   show: shared-temp.with(
//     title: "Test",
//     author: "test",
//     venue: "test",
//     date: "2025-09-10"
//   )
//   body
// }

// #let pub-body = main

#let pub-body2(pub) = [
  #pub.author

  #pub.date

  #pub.conferenceName

  #pub.abstractNote
]
