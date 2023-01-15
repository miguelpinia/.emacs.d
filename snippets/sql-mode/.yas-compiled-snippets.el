;;; Compiled snippets and support files for `sql-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'sql-mode
                     '(("sel1" "select ${1:*} from $2;" "select" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/select" "direct-keybinding" nil)
                       ("schema" "create schema ${1:schema};\n$0" "schema" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/schema" "direct-keybinding" nil)
                       ("references" "REFERENCES ${1:TableName}([${2:ColumnName}])\n" "REFERENCES ..." nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/references" nil nil)
                       ("nuevo" "  -- ${2:descripción}\n  , ${1:dato}\n$0" "inserta nuevo elemento" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/nuevo" "C-c C-m C-k" nil)
                       ("insert" "insert into ${1:tabla} (${2:columnas}) values (${3:valores});\n$0" "insert" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/insert" "direct-keybinding" nil)
                       ("drtab" "drop table if exists ${1:table};\n$0" "drtab" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/drtab" "direct-keybinding" nil)
                       ("drschc" "drop schema ${1:schema} cascade;\n$0" "drschc" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/drschc" "direct-keybinding" nil)
                       ("drpv" "drop view if exists ${1:view};\n$0" "drpv" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/drpv" "direct-keybinding" nil)
                       ("do" "do language plpgsql $$\ndeclare\n${1:atributos}\nbegin\n${0:instrucciones}\nend;\n$$" "do" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/do" "direct-keybinding" nil)
                       ("create.1" "CREATE PROCEDURE [${1:dbo}].[${2:Name}] \n(\n		$3		$4		= ${5:NULL}		${6:OUTPUT}\n)\nAS\nBEGIN\n$0\nEND\nGO\n" "create procedure ..." nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/create.1" nil nil)
                       ("create" "create table ${1:tabla} (\n  -- ${2:Descripción}\n  id serial primary key\n  $0\n);" "create" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/create" "direct-keybinding" nil)
                       ("constraint.1" "CONSTRAINT [${1:FK_Name}] FOREIGN KEY ${2:CLUSTERED} ([${3:ColumnName}]) \n" "CONSTRAINT [..] FOREIGN KEY ..." nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/constraint.1" nil nil)
                       ("constraint" "CONSTRAINT [${1:PK_Name}] PRIMARY KEY ${2:CLUSTERED} ([${3:ColumnName}]) \n" "CONSTRAINT [..] PRIMARY KEY ..." nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/constraint" nil nil)
                       ("column" "	,	${1:Name}		${2:Type}			${3:NOT NULL}\n" ", ColumnName ColumnType NOT NULL..." nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/column" nil nil)
                       ("begin" "/**\n * Copyright (C) 2014 Facultad de Ciencias. UNAM.\n *\n * Este archivo es parte de la base de datos escolar.\n *\n * La base de datos escolar es software libre: lo puede redistribuir\n * y/o modificar bajo los términos de la licencia GNU General Public\n * License como se publica por la Free Software Foundation, ya sea la\n * version 3 de la licencia, o (según su elección) cualquier versión\n * posterior.\n *\n * La base de datos escolar se distribuye con la esperanza de que sea\n * útil, pero SIN NINGUNA GARANTÍA, incluso sin la garantía implícita\n * de COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Véase\n * la licencia GNU General Public License para más detalles.\n *\n * Usted debería haber recibido una copia de la Licencia Pública\n * General de GNU junto con la base de datos escolar. Si no, véase\n * <http://www.gnu.org/licenses/>.\n */\nbegin;\nset client_encoding = 'utf-8';\n\n-- ${2:descripción}\ncreate schema ${1:schema};\n\n$0\n\ncommit;" "begin" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/begin" "direct-keybinding" nil)
                       ("be" "begin;\nset client_encoding = 'utf-8';\n\n$0\n\ncommit;" "begin" nil nil nil "/home/miguel/.emacs.d/snippets/sql-mode/be" "direct-keybinding" nil)))


;;; Do not edit! File generated at Wed Jan 11 13:04:49 2023
