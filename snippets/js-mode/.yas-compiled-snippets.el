;;; Compiled snippets and support files for `js-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'js-mode
                     '(("req.json" "new Request.JSON({\n  onSuccess: function(responseJSON, responseText) {\n    $0\n  }\n}).${1:send}(${2:url});" "json" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/req.json" nil nil)
                       ("req.html" "new Request.HTML({\n  onSuccess: function(responseTree, responseElements, responseHTML, responseJavaScript) {\n    $0\n  }\n}).${1:get}(${2:url});" "html" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/req.html" nil nil)
                       ("log" "console.log($0);" "console.log" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/log" nil nil)
                       ("itex" "it('$1', async () => {\n  await expect(page).toMatch('$2');\n})" "it expect simple" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/itex" nil nil)
                       ("init" "initialize: function($1) {\n  $0\n}" "Constructor" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/init" nil nil)
                       ("immi" "import ${1:Object} from '@material-ui/icons/$1'`(if (eolp) (js-react-redux-yasnippets-semicolon))`;" "Import from @material-ui/icons" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/immi" nil "immi")
                       ("immc" "import ${1:Object} from '@material-ui/core/$1'`(if (eolp) (js-react-redux-yasnippets-semicolon))`" "Import from @material-ui/core" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/immc" nil "immc")
                       ("if" "if (${1:condition}) {\n  $0\n}" "if" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/if" nil nil)
                       ("for" "for(var ${1:i} = ${2:0}; $1 < ${3:collection}.length; $1++) {\n  $0\n}" "for" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/for" nil nil)
                       ("fn1" "($1) => ($0)" "Lambda function without body" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/fn1" nil nil)
                       ("fn" "($1) => {\n  $0\n}" "fn" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/fn" nil nil)
                       ("f" "function($1) {\n  $0\n}" "anonymous function" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/f" nil nil)
                       ("expc" "export const $1 = '$1';" "export const" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/expc" nil nil)
                       ("ev.fire" "fireEvent('$0')" "fireEvent" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/ev.fire" nil nil)
                       ("ev.add" "addEvent('${1:event}', function($2) {\n  $0\n});" "addEvent" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/ev.add" nil nil)
                       ("el" "else {\n  $0\n}" "else" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/el" nil nil)
                       ("each" "${1:collection}.each(function($2) {\n  $0\n});" "each" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/each" nil nil)
                       ("ds" "describe('$1', () => {\n  let browser;\n  let page;\n\n  beforeAll(async () => {\n    browser = await puppeteer.launch(puppeteerArgs);\n    page = await browser.newPage();\n    await page.goto('http://localhost:3000', { waitUntil: 'networkidle2' });\n    await expectPuppeteer(page).toFillForm('form', {\n      usuario: 'foo@mail.com',\n      password: 'bar'\n    });\n    await page.click('button[type=submit]');\n    await page.waitForSelector('html');\n    await page.waitFor(200);\n  });\n\n  afterAll(async () => {\n    await browser.close();\n  });\n\n $0\n\n})`(js-react-redux-yasnippets-semicolon)`" "describe test block" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/ds" nil "ds")
                       ("def" "${1:name}: function($2) {\n  $0\n}" "function" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/def" nil nil)
                       ("createc" "const $1 = (req, res, next) => {\n   const {$2} = req.body.data;\n   if ($3) {\n      res.status(400).json({\n        message:\n         'Te faltó especificar $4. Observa los atributos faltantes para más información.',\n        faltantes: [$5]\n      });\n   };\n   $6.create({\n        $2\n   }).then(($7) => {\n     console.log(\n       req.protocol +\n         ' ' +\n         req.method +\n         ' ' +\n         req.path +\n         ' -- ' +\n         req.ip +\n         ' -- 200 (OK)'\n     );\n     res.status(200).json({\n       message: '',\n       $7: $7\n     });\n   }).catch((err) => {\n     console.error(err.message);\n     res.status(500).json({\n       message:\n         ''\n     });\n  });\n};" "Create controller" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/createc" nil nil)
                       ("cpd" "case $1:\n  return {...state, $2: action.payload};\n$0" "case básico para el switch de un reducer" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/cpd" nil nil)
                       ("com" "/*\n * $0\n */" "comment (/* ... */)" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/com" nil nil)
                       ("class" "var ${1:name} = new Class({\n  initialize: function($2) {\n    $0\n  }\n});" "Class" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/class" nil nil)
                       ("apost" "await axios\n   .post(\n       $1\n   )\n   .then((response) => {\n       $2\n   })\n   .catch((err) => {\n       console.log(err);\n   });" "apost" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/apost" nil nil)
                       ("alam" "async ($1) => {\n  $0\n}" "Async function" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/alm" nil nil)
                       ("al" "alert($0);" "alert" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/al" nil nil)
                       ("ahook" "const $1 = async (${2:props}) => {\n  $0\n};" "async custom hook" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/ahook" nil nil)
                       ("adelete" "await axios\n   .delete(\n       $1\n   )\n   .then(\n       $0\n   );" "" nil nil nil "/home/miguel/.emacs.d/snippets/js-mode/adelete" nil "adelete")))


;;; Do not edit! File generated at Mon Aug  9 14:21:33 2021
