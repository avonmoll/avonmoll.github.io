#import "@preview/cmarker:0.1.5"
#import "blog.typ": markup-rules, equation-rules, code-block-rules
// markup setting
#show: markup-rules
// math setting
#show: equation-rules
// code block setting
#show: code-block-rules
#show raw.where(lang: "md-render"): it => cmarker.render(
  raw-typst: false,
  it.text,
  h1-level: 2,
)
