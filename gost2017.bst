% GOST 7.32-2017 Bibliography Style
% Based on plain.bst with GOST formatting

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
    language
    url
    urldate
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ " " * write$ }
        { output.state before.all =
            'write$
            { after.sentence 'output.state := }
          if$
        }
      if$
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll}{, f.}{, jj}{, vv}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { numnames #2 >
                { "," * }
                'skip$
              if$
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                { " и~др." * }
                { " и " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { " (ред.)" * }
        { " (ред.)" * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {format.journal}
{ journal empty$
    { "" }
    { "{\em " journal * "}" * }
  if$
}

FUNCTION {format.booktitle}
{ booktitle empty$
    { "" }
    { "В {\em " booktitle * "}" * }
  if$
}

FUNCTION {format.volume}
{ volume empty$
    { "" }
    { "Т. " volume * }
  if$
}

FUNCTION {format.number}
{ number empty$
    { "" }
    { "№ " number * }
  if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { "с. " pages * }
  if$
}

FUNCTION {format.publisher.address}
{ publisher empty$
    { address empty$
        { "" }
        { address }
      if$
    }
    { address empty$
        { publisher }
        { address ", " * publisher * }
      if$
    }
  if$
}

FUNCTION {format.year}
{ year empty$
    { "" }
    { year }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition " изд." * }
  if$
}

FUNCTION {format.address}
{ address empty$
    { "" }
    { address }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { "URL: " url * }
  if$
}

FUNCTION {format.urldate}
{ urldate empty$
    { "" }
    { " (дата обращения: " urldate * ")" * }
  if$
}

FUNCTION {article}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  format.journal output.nonnull
  format.volume output.nonnull
  format.number output.nonnull
  format.pages output.nonnull
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  format.edition output
  format.publisher.address output.nonnull
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  format.booktitle output.nonnull
  format.pages output.nonnull
  format.publisher.address output.nonnull
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  "Дис. ... канд. техн. наук" output.nonnull
  school empty$
    { "" }
    { school * }
  if$
  format.address output
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  howpublished empty$
    { "" }
    { howpublished * }
  if$
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {online}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  "Электронный ресурс." output.nonnull
  howpublished empty$
    { "" }
    { howpublished * }
  if$
  format.url output
  format.urldate output
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {standard}
{ output.bibitem
  organization empty$
    { "" }
    { organization * }
  if$
  number empty$
    { "" }
    { " " * number * }
  if$
  format.title output.nonnull
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {patent}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  number empty$
    { "" }
    { "Патент РФ " * number * }
  if$
  year empty$
    { "" }
    { ", " * year * }
  if$
  new.block
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  institution empty$
    { "" }
    { institution * }
  if$
  number empty$
    { "" }
    { "Отчет № " * number * }
  if$
  format.address output
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  note empty$
    { "" }
    { note * }
  if$
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  "Магистерская диссертация" output.nonnull
  school empty$
    { "" }
    { school * }
  if$
  format.address output
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  format.booktitle output.nonnull
  format.pages output
  format.publisher.address output.nonnull
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  format.booktitle output.nonnull
  format.pages output
  format.publisher.address output.nonnull
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {manual}
{ output.bibitem
  format.authors output
  format.title output.nonnull
  organization empty$
    { "" }
    { organization * }
  if$
  address empty$
    { "" }
    { address * }
  if$
  format.edition output
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  format.title output.nonnull
  editor empty$
    { "" }
    { format.editors * }
  if$
  organization empty$
    { "" }
    { organization * }
  if$
  format.publisher.address output.nonnull
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {report}
{ output.bibitem
  format.authors output.nonnull
  format.title output.nonnull
  institution empty$
    { "" }
    { institution * }
  if$
  number empty$
    { "" }
    { "Отчет № " * number * }
  if$
  format.address output
  format.year output.nonnull
  new.block
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"янв."}
MACRO {feb} {"февр."}
MACRO {mar} {"март"}
MACRO {apr} {"апр."}
MACRO {may} {"май"}
MACRO {jun} {"июнь"}
MACRO {jul} {"июль"}
MACRO {aug} {"авг."}
MACRO {sep} {"сент."}
MACRO {oct} {"окт."}
MACRO {nov} {"нояб."}
MACRO {dec} {"дек."}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            'author.sort
          if$
        }
      if$
    }
  if$
  "    "
  * year field.or.null sortify
  * "    "
  * title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  "}" write$ newline$
}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {init.state.consts}
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}