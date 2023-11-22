local optl = vim.opt_local

optl.comments = "nb:>"

optl.comments:append("b:- [ ],b:- [x],b:-")
optl.comments:append("b:*")
optl.comments:append("b:1.")

optl.formatoptions:remove("c")
optl.formatoptions:append("jro")
