;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (vassoc set-modified-alist modify-alist remove-alist
;;;;;;  set-alist del-alist put-alist) "alist" "../../../../../.emacs.d/el-get/apel/site-lisp/apel/alist.el"
;;;;;;  (19831 41366))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/apel/site-lisp/apel/alist.el

(autoload 'put-alist "alist" "\
Set cdr of an element (KEY . ...) in ALIST to VALUE and return ALIST.
If there is no such element, create a new pair (KEY . VALUE) and
return a new alist whose car is the new pair and cdr is ALIST.

\(fn KEY VALUE ALIST)" nil nil)

(autoload 'del-alist "alist" "\
Delete an element whose car equals KEY from ALIST.
Return the modified ALIST.

\(fn KEY ALIST)" nil nil)

(autoload 'set-alist "alist" "\
Set cdr of an element (KEY . ...) in the alist bound to SYMBOL to VALUE.

\(fn SYMBOL KEY VALUE)" nil nil)

(autoload 'remove-alist "alist" "\
Delete an element whose car equals KEY from the alist bound to SYMBOL.

\(fn SYMBOL KEY)" nil nil)

(autoload 'modify-alist "alist" "\
Store elements in the alist MODIFIER in the alist DEFAULT.
Return the modified alist.

\(fn MODIFIER DEFAULT)" nil nil)

(autoload 'set-modified-alist "alist" "\
Store elements in the alist MODIFIER in an alist bound to SYMBOL.
If SYMBOL is not bound, set it to nil at first.

\(fn SYMBOL MODIFIER)" nil nil)

(autoload 'vassoc "alist" "\
Search AVLIST for an element whose first element equals KEY.
AVLIST is a list of vectors.
See also `assoc'.

\(fn KEY AVLIST)" nil nil)

;;;***

;;;### (autoloads (bbdb-wl-setup) "bbdb-wl" "../../../../../.emacs.d/el-get/wanderlust/utils/bbdb-wl.el"
;;;;;;  (19831 41475))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/wanderlust/utils/bbdb-wl.el

(autoload 'bbdb-wl-setup "bbdb-wl" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (elmo-make-folder) "elmo" "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo.el"
;;;;;;  (19831 41475))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo.el

(autoload 'elmo-make-folder "elmo" "\
Make an ELMO folder structure specified by NAME.
If optional argument NON-PERSISTENT is non-nil, the folder msgdb is not saved.
If optional argument MIME-CHARSET is specified, it is used for
encode and decode a multibyte string.

\(fn NAME &optional NON-PERSISTENT MIME-CHARSET)" nil nil)

;;;***

;;;### (autoloads (elmo-split) "elmo-split" "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-split.el"
;;;;;;  (19831 41475))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-split.el

(autoload 'elmo-split "elmo-split" "\
Split messages in the `elmo-split-folder' according to `elmo-split-rule'.
If prefix argument ARG is specified, do a reharsal (no harm).

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (mime-decode-header-in-buffer mime-decode-header-in-region
;;;;;;  mime-decode-field-body mime-update-field-decoder-cache mime-find-field-decoder
;;;;;;  mime-find-field-presentation-method mime-set-field-decoder)
;;;;;;  "eword-decode" "../../../../../.emacs.d/el-get/flim/site-lisp/flim/eword-decode.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/eword-decode.el

(autoload 'mime-set-field-decoder "eword-decode" "\
Set decoder of FIELD.
SPECS must be like `MODE1 DECODER1 MODE2 DECODER2 ...'.
Each mode must be `nil', `plain', `wide', `summary' or `nov'.
If mode is `nil', corresponding decoder is set up for every modes.

\(fn FIELD &rest SPECS)" nil nil)

(autoload 'mime-find-field-presentation-method "eword-decode" "\
Return field-presentation-method from NAME.
NAME must be `plain', `wide', `summary' or `nov'.

\(fn NAME)" nil (quote macro))

(autoload 'mime-find-field-decoder "eword-decode" "\
Return function to decode field-body of FIELD in MODE.
Optional argument MODE must be object or name of
field-presentation-method.  Name of field-presentation-method must be
`plain', `wide', `summary' or `nov'.
Default value of MODE is `summary'.

\(fn FIELD &optional MODE)" nil nil)

(autoload 'mime-update-field-decoder-cache "eword-decode" "\
Update field decoder cache `mime-field-decoder-cache'.

\(fn FIELD MODE &optional FUNCTION)" nil nil)

(autoload 'mime-decode-field-body "eword-decode" "\
Decode FIELD-BODY as FIELD-NAME in MODE, and return the result.
Optional argument MODE must be `plain', `wide', `summary' or `nov'.
Default mode is `summary'.

If MODE is `wide' and MAX-COLUMN is non-nil, the result is folded with
MAX-COLUMN.

Non MIME encoded-word part in FILED-BODY is decoded with
`default-mime-charset'.

\(fn FIELD-BODY FIELD-NAME &optional MODE MAX-COLUMN)" nil nil)

(autoload 'mime-decode-header-in-region "eword-decode" "\
Decode MIME encoded-words in region between START and END.
If CODE-CONVERSION is nil, it decodes only encoded-words.  If it is
mime-charset, it decodes non-ASCII bit patterns as the mime-charset.
Otherwise it decodes non-ASCII bit patterns as the
default-mime-charset.

\(fn START END &optional CODE-CONVERSION)" t nil)

(autoload 'mime-decode-header-in-buffer "eword-decode" "\
Decode MIME encoded-words in header fields.
If CODE-CONVERSION is nil, it decodes only encoded-words.  If it is
mime-charset, it decodes non-ASCII bit patterns as the mime-charset.
Otherwise it decodes non-ASCII bit patterns as the
default-mime-charset.
If SEPARATOR is not nil, it is used as header separator.

\(fn &optional CODE-CONVERSION SEPARATOR)" t nil)

;;;***

;;;### (autoloads (mime-encode-header-in-buffer mime-encode-field-body)
;;;;;;  "eword-encode" "../../../../../.emacs.d/el-get/flim/site-lisp/flim/eword-encode.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/eword-encode.el

(autoload 'mime-encode-field-body "eword-encode" "\
Encode FIELD-BODY as FIELD-NAME, and return the result.
A lexical token includes non-ASCII character is encoded as MIME
encoded-word.  ASCII token is not encoded.

\(fn FIELD-BODY FIELD-NAME)" nil nil)

(autoload 'mime-encode-header-in-buffer "eword-encode" "\
Encode header fields to network representation, such as MIME encoded-word.
It refers the `mime-field-encoding-method-alist' variable.

\(fn &optional CODE-CONVERSION)" t nil)

;;;***

;;;### (autoloads (wl-draft-send-with-imput-async) "im-wl" "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/im-wl.el"
;;;;;;  (19831 41475))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/im-wl.el

(autoload 'wl-draft-send-with-imput-async "im-wl" "\
Send the message in the current buffer with imput asynchronously.

\(fn EDITING-BUFFER KILL-WHEN-DONE)" nil nil)

;;;***

;;;### (autoloads (mime-write-decoded-region mime-insert-encoded-file
;;;;;;  mime-decode-string mime-decode-region mime-encode-region)
;;;;;;  "mel" "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel.el

(autoload 'mime-encode-region "mel" "\
Encode region START to END of current buffer using ENCODING.
ENCODING must be string.

\(fn START END ENCODING)" t nil)

(autoload 'mime-decode-region "mel" "\
Decode region START to END of current buffer using ENCODING.
ENCODING must be string.

\(fn START END ENCODING)" t nil)

(autoload 'mime-decode-string "mel" "\
Decode STRING using ENCODING.
ENCODING must be string.  If ENCODING is found in
`mime-string-decoding-method-alist' as its key, this function decodes
the STRING by its value.

\(fn STRING ENCODING)" nil nil)

(autoload 'mime-insert-encoded-file "mel" "\
Insert file FILENAME encoded by ENCODING format.

\(fn FILENAME ENCODING)" t nil)

(autoload 'mime-write-decoded-region "mel" "\
Decode and write current region encoded by ENCODING into FILENAME.
START and END are buffer positions.

\(fn START END FILENAME ENCODING)" t nil)

;;;***

;;;### (autoloads (mime-format-mailcap-command mime-parse-mailcap-file
;;;;;;  mime-parse-mailcap-buffer) "mime-conf" "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mime-conf.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/mime-conf.el

(autoload 'mime-parse-mailcap-buffer "mime-conf" "\
Parse BUFFER as a mailcap, and return the result.
If optional argument ORDER is a function, result is sorted by it.
If optional argument ORDER is not specified, result is sorted original
order.  Otherwise result is not sorted.

\(fn &optional BUFFER ORDER)" nil nil)

(defvar mime-mailcap-file "~/.mailcap" "\
*File name of user's mailcap file.")

(autoload 'mime-parse-mailcap-file "mime-conf" "\
Parse FILENAME as a mailcap, and return the result.
If optional argument ORDER is a function, result is sorted by it.
If optional argument ORDER is not specified, result is sorted original
order.  Otherwise result is not sorted.

\(fn &optional FILENAME ORDER)" nil nil)

(autoload 'mime-format-mailcap-command "mime-conf" "\
Return formated command string from MTEXT and SITUATION.

MTEXT is a command text of mailcap specification, such as
view-command.

SITUATION is an association-list about information of entity.  Its key
may be:

	'type		primary media-type
	'subtype	media-subtype
	'filename	filename
	STRING		parameter of Content-Type field

\(fn MTEXT SITUATION)" nil nil)

;;;***

;;;### (autoloads (mime-edit-again mime-edit-decode-message-in-buffer
;;;;;;  turn-on-mime-edit mime-edit-mode) "mime-edit" "../../../../../.emacs.d/el-get/semi/mime-edit.el"
;;;;;;  (19831 41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/mime-edit.el

(autoload 'mime-edit-mode "mime-edit" "\
MIME minor mode for editing the tagged MIME message.

In this mode, basically, the message is composed in the tagged MIME
format. The message tag looks like:

	--[[text/plain; charset=ISO-2022-JP][7bit]]

The tag specifies the MIME content type, subtype, optional parameters
and transfer encoding of the message following the tag.  Messages
without any tag are treated as `text/plain' by default.  Charset and
transfer encoding are automatically defined unless explicitly
specified.  Binary messages such as audio and image are usually
hidden.  The messages in the tagged MIME format are automatically
translated into a MIME compliant message when exiting this mode.

Available charsets depend on Emacs version being used.  The following
lists the available charsets of each emacs.

Without mule:	US-ASCII and ISO-8859-1 (or other charset) are available.
With mule:	US-ASCII, ISO-8859-* (except for ISO-8859-5), KOI8-R,
		ISO-2022-JP, ISO-2022-JP-2, EUC-KR, CN-GB-2312,
		CN-BIG5 and ISO-2022-INT-1 are available.

ISO-2022-JP-2 and ISO-2022-INT-1 charsets used in mule is expected to
be used to represent multilingual text in intermixed manner.  Any
languages that has no registered charset are represented as either
ISO-2022-JP-2 or ISO-2022-INT-1 in mule.

If you want to use non-ISO-8859-1 charset in Emacs 19 or XEmacs
without mule, please set variable `default-mime-charset'.  This
variable must be symbol of which name is a MIME charset.

If you want to add more charsets in mule, please set variable
`charsets-mime-charset-alist'.  This variable must be alist of which
key is list of charset and value is symbol of MIME charset.  If name
of coding-system is different as MIME charset, please set variable
`mime-charset-coding-system-alist'.  This variable must be alist of
which key is MIME charset and value is coding-system.

Following commands are available in addition to major mode commands:

\[make single part]
\\[mime-edit-insert-text]	insert a text message.
\\[mime-edit-insert-file]	insert a (binary) file.
\\[mime-edit-insert-external]	insert a reference to external body.
\\[mime-edit-insert-voice]	insert a voice message.
\\[mime-edit-insert-message]	insert a mail or news message.
\\[mime-edit-insert-mail]	insert a mail message.
\\[mime-edit-insert-signature]	insert a signature file at end.
\\[mime-edit-insert-key]	insert PGP public key.
\\[mime-edit-insert-tag]	insert a new MIME tag.

\[make enclosure (maybe multipart)]
\\[mime-edit-enclose-alternative-region]   enclose as multipart/alternative.
\\[mime-edit-enclose-parallel-region]	   enclose as multipart/parallel.
\\[mime-edit-enclose-mixed-region]	   enclose as multipart/mixed.
\\[mime-edit-enclose-digest-region]	   enclose as multipart/digest.
\\[mime-edit-enclose-pgp-signed-region]	   enclose as PGP signed.
\\[mime-edit-enclose-pgp-encrypted-region] enclose as PGP encrypted.
\\[mime-edit-enclose-quote-region]	   enclose as verbose mode
					   (to avoid to expand tags)

\[other commands]
\\[mime-edit-set-transfer-level-7bit]	set transfer-level as 7.
\\[mime-edit-set-transfer-level-8bit]	set transfer-level as 8.
\\[mime-edit-set-split]			set message splitting mode.
\\[mime-edit-set-sign]			set PGP-sign mode.
\\[mime-edit-set-encrypt]		set PGP-encryption mode.
\\[mime-edit-preview-message]		preview editing MIME message.
\\[mime-edit-exit]			exit and translate into a MIME
					compliant message.
\\[mime-edit-help]			show this help.
\\[mime-edit-maybe-translate]		exit and translate if in MIME mode,
					then split.

Additional commands are available in some major modes:
C-c C-c		exit, translate and run the original command.
C-c C-s		exit, translate and run the original command.

The following is a message example written in the tagged MIME format.
TABs at the beginning of the line are not a part of the message:

	This is a conventional plain text.  It should be translated
	into text/plain.
	--[[text/plain]]
	This is also a plain text.  But, it is explicitly specified as
	is.
	--[[text/plain; charset=ISO-8859-1]]
	This is also a plain text.  But charset is specified as
	iso-8859-1.

	¡Hola!  Buenos días.  ¿Cómo está usted?
	--[[text/enriched]]
	This is a <bold>enriched text</bold>.
	--[[image/gif][base64]]...image encoded in base64 here...
	--[[audio/basic][base64]]...audio encoded in base64 here...

User customizable variables (not documented all of them):
 mime-edit-prefix
    Specifies a key prefix for MIME minor mode commands.

 mime-ignore-preceding-spaces
    Preceding white spaces in a message body are ignored if non-nil.

 mime-ignore-trailing-spaces
    Trailing white spaces in a message body are ignored if non-nil.

 mime-auto-hide-body
    Hide a non-textual body message encoded in base64 after insertion
    if non-nil.

 mime-transfer-level
    A number of network transfer level.  It should be bigger than 7.
    If you are in 8bit-through environment, please set 8.

 mime-edit-voice-recorder
    Specifies a function to record a voice message and encode it.
    The function `mime-edit-voice-recorder-for-sun' is for Sun
    SparcStations.

 mime-edit-mode-hook
    Turning on MIME mode calls the value of mime-edit-mode-hook, if
    it is non-nil.

 mime-edit-translate-hook
    The value of mime-edit-translate-hook is called just before translating
    the tagged MIME format into a MIME compliant message if it is
    non-nil.  If the hook call the function mime-edit-insert-signature,
    the signature file will be inserted automatically.

 mime-edit-exit-hook
    Turning off MIME mode calls the value of mime-edit-exit-hook, if it is
    non-nil.

\(fn)" t nil)

(autoload 'turn-on-mime-edit "mime-edit" "\
Unconditionally turn on MIME-Edit mode.

\(fn)" t nil)

(defalias 'edit-mime 'turn-on-mime-edit)

(autoload 'mime-edit-decode-message-in-buffer "mime-edit" "\
Not documented

\(fn &optional DEFAULT-CONTENT-TYPE NOT-DECODE-TEXT)" nil nil)

(autoload 'mime-edit-again "mime-edit" "\
Convert current buffer to MIME-Edit buffer and turn on MIME-Edit mode.
Content-Type and Content-Transfer-Encoding header fields will be
converted to MIME-Edit tags.

\(fn &optional NOT-DECODE-TEXT NO-SEPARATOR NOT-TURN-ON)" t nil)

;;;***

;;;### (autoloads (mime-parse-buffer mime-uri-parse-cid mime-parse-msg-id
;;;;;;  mime-read-Content-Transfer-Encoding mime-parse-Content-Transfer-Encoding
;;;;;;  mime-read-Content-Disposition mime-parse-Content-Disposition
;;;;;;  mime-read-Content-Type mime-parse-Content-Type) "mime-parse"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mime-parse.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/mime-parse.el

(autoload 'mime-parse-Content-Type "mime-parse" "\
Parse FIELD-BODY as a Content-Type field.
FIELD-BODY is a string.
Return value is a mime-content-type object.
If FIELD-BODY is not a valid Content-Type field, return nil.

\(fn FIELD-BODY)" nil nil)

(autoload 'mime-read-Content-Type "mime-parse" "\
Parse field-body of Content-Type field of current-buffer.
Return value is a mime-content-type object.
If Content-Type field is not found, return nil.

\(fn)" nil nil)

(autoload 'mime-parse-Content-Disposition "mime-parse" "\
Parse FIELD-BODY as a Content-Disposition field.
FIELD-BODY is a string.
Return value is a mime-content-disposition object.
If FIELD-BODY is not a valid Content-Disposition field, return nil.

\(fn FIELD-BODY)" nil nil)

(autoload 'mime-read-Content-Disposition "mime-parse" "\
Parse field-body of Content-Disposition field of current-buffer.
Return value is a mime-content-disposition object.
If Content-Disposition field is not found, return nil.

\(fn)" nil nil)

(autoload 'mime-parse-Content-Transfer-Encoding "mime-parse" "\
Parse FIELD-BODY as a Content-Transfer-Encoding field.
FIELD-BODY is a string.
Return value is a string.
If FIELD-BODY is not a valid Content-Transfer-Encoding field, return nil.

\(fn FIELD-BODY)" nil nil)

(autoload 'mime-read-Content-Transfer-Encoding "mime-parse" "\
Parse field-body of Content-Transfer-Encoding field of current-buffer.
Return value is a string.
If Content-Transfer-Encoding field is not found, return nil.

\(fn)" nil nil)

(autoload 'mime-parse-msg-id "mime-parse" "\
Parse TOKENS as msg-id of Content-ID or Message-ID field.

\(fn TOKENS)" nil nil)

(autoload 'mime-uri-parse-cid "mime-parse" "\
Parse STRING as cid URI.

\(fn STRING)" nil nil)

(autoload 'mime-parse-buffer "mime-parse" "\
Parse BUFFER as a MIME message.
If buffer is omitted, it parses current-buffer.

\(fn &optional BUFFER REPRESENTATION-TYPE)" nil nil)

;;;***

;;;### (autoloads (mime-play-entity mime-preview-play-current-entity)
;;;;;;  "mime-play" "../../../../../.emacs.d/el-get/semi/mime-play.el"
;;;;;;  (19831 41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/mime-play.el

(autoload 'mime-preview-play-current-entity "mime-play" "\
Play current entity.
It decodes current entity to call internal or external method.  The
method is selected from variable `mime-acting-condition'.
If IGNORE-EXAMPLES (C-u prefix) is specified, this function ignores
`mime-acting-situation-example-list'.
If MODE is specified, play as it.  Default MODE is \"play\".

\(fn &optional IGNORE-EXAMPLES MODE)" t nil)

(autoload 'mime-play-entity "mime-play" "\
Play entity specified by ENTITY.
It decodes the entity to call internal or external method.  The method
is selected from variable `mime-acting-condition'.  If MODE is
specified, play as it.  Default MODE is \"play\".

\(fn ENTITY &optional SITUATION IGNORED-METHOD)" nil nil)

;;;***

;;;### (autoloads (mime-view-buffer mime-display-message) "mime-view"
;;;;;;  "../../../../../.emacs.d/el-get/semi/mime-view.el" (19831
;;;;;;  41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/mime-view.el

(autoload 'mime-display-message "mime-view" "\
View MESSAGE in MIME-View mode.

Optional argument PREVIEW-BUFFER specifies the buffer of the
presentation.  It must be either nil or a name of preview buffer.

Optional argument MOTHER specifies mother-buffer of the preview-buffer.

Optional argument DEFAULT-KEYMAP-OR-FUNCTION is nil, keymap or
function.  If it is a keymap, keymap of MIME-View mode will be added
to it.  If it is a function, it will be bound as default binding of
keymap of MIME-View mode.

Optional argument ORIGINAL-MAJOR-MODE is major-mode of representation
buffer of MESSAGE.  If it is nil, current `major-mode' is used.

Optional argument KEYMAP is keymap of MIME-View mode.  If it is
non-nil, DEFAULT-KEYMAP-OR-FUNCTION is ignored.  If it is nil,
`mime-view-mode-default-map' is used.

\(fn MESSAGE &optional PREVIEW-BUFFER MOTHER DEFAULT-KEYMAP-OR-FUNCTION ORIGINAL-MAJOR-MODE KEYMAP)" nil nil)

(autoload 'mime-view-buffer "mime-view" "\
View RAW-BUFFER in MIME-View mode.
Optional argument PREVIEW-BUFFER is either nil or a name of preview
buffer.
Optional argument DEFAULT-KEYMAP-OR-FUNCTION is nil, keymap or
function.  If it is a keymap, keymap of MIME-View mode will be added
to it.  If it is a function, it will be bound as default binding of
keymap of MIME-View mode.
Optional argument REPRESENTATION-TYPE is representation-type of
message.  It must be nil, `binary' or `cooked'.  If it is nil,
`cooked' is used as default.

\(fn &optional RAW-BUFFER PREVIEW-BUFFER MOTHER DEFAULT-KEYMAP-OR-FUNCTION REPRESENTATION-TYPE)" t nil)

;;;***

;;;### (autoloads (org-google-weather) "org-google-weather" "../../../../../.emacs.d/el-get/google-weather/org-google-weather.el"
;;;;;;  (19831 41896))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/google-weather/org-google-weather.el

(autoload 'org-google-weather "org-google-weather" "\
Return Org entry with the weather for LOCATION in LANGUAGE.
If LOCATION is not set, use org-google-weather-location.

\(fn &optional LOCATION LANGUAGE)" nil nil)

;;;***

;;;### (autoloads (module-installed-p exec-installed-p file-installed-p
;;;;;;  get-latest-path add-latest-path add-path) "path-util" "../../../../../.emacs.d/el-get/apel/site-lisp/apel/path-util.el"
;;;;;;  (19831 41366))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/apel/site-lisp/apel/path-util.el

(autoload 'add-path "path-util" "\
Add PATH to `load-path' if it exists under `default-load-path'
directories and it does not exist in `load-path'.

You can use following PATH styles:
	load-path relative: \"PATH/\"
			(it is searched from `default-load-path')
	home directory relative: \"~/PATH/\" \"~USER/PATH/\"
	absolute path: \"/HOO/BAR/BAZ/\"

You can specify following OPTIONS:
	'all-paths	search from `load-path'
			instead of `default-load-path'
	'append		add PATH to the last of `load-path'

\(fn PATH &rest OPTIONS)" nil nil)

(autoload 'add-latest-path "path-util" "\
Add latest path matched by PATTERN to `load-path'
if it exists under `default-load-path' directories
and it does not exist in `load-path'.

If optional argument ALL-PATHS is specified, it is searched from all
of load-path instead of default-load-path.

\(fn PATTERN &optional ALL-PATHS)" nil nil)

(autoload 'get-latest-path "path-util" "\
Return latest directory in default-load-path
which is matched to regexp PATTERN.
If optional argument ALL-PATHS is specified,
it is searched from all of load-path instead of default-load-path.

\(fn PATTERN &optional ALL-PATHS)" nil nil)

(autoload 'file-installed-p "path-util" "\
Return absolute-path of FILE if FILE exists in PATHS.
If PATHS is omitted, `load-path' is used.

\(fn FILE &optional PATHS)" nil nil)

(defvar exec-suffix-list '("") "\
*List of suffixes for executable.")

(autoload 'exec-installed-p "path-util" "\
Return absolute-path of FILE if FILE exists in PATHS.
If PATHS is omitted, `exec-path' is used.
If suffixes is omitted, `exec-suffix-list' is used.

\(fn FILE &optional PATHS SUFFIXES)" nil nil)

(autoload 'module-installed-p "path-util" "\
Return t if module is provided or exists in PATHS.
If PATHS is omitted, `load-path' is used.

\(fn MODULE &optional PATHS)" nil nil)

;;;***

;;;### (autoloads (pgg-snarf-keys-region pgg-insert-key pgg-verify-region
;;;;;;  pgg-sign-region pgg-decrypt-region pgg-encrypt-region) "pgg"
;;;;;;  "../../../../../.emacs.d/el-get/semi/pgg.el" (19831 41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/pgg.el

(autoload 'pgg-encrypt-region "pgg" "\
Encrypt the current region between START and END for RCPTS.

\(fn START END RCPTS)" t nil)

(autoload 'pgg-decrypt-region "pgg" "\
Decrypt the current region between START and END.

\(fn START END)" t nil)

(autoload 'pgg-sign-region "pgg" "\
Make the signature from text between START and END.
If the optional 3rd argument CLEARTEXT is non-nil, it does not create
a detached signature.

\(fn START END &optional CLEARTEXT)" t nil)

(autoload 'pgg-verify-region "pgg" "\
Verify the current region between START and END.
If the optional 3rd argument SIGNATURE is non-nil, it is treated as
the detached signature of the current region.

If the optional 4th argument FETCH is non-nil, we attempt to fetch the
signer's public key from `pgg-default-keyserver-address'.

\(fn START END &optional SIGNATURE FETCH)" t nil)

(autoload 'pgg-insert-key "pgg" "\
Insert the ASCII armored public key.

\(fn)" t nil)

(autoload 'pgg-snarf-keys-region "pgg" "\
Import public keys in the current region between START and END.

\(fn START END)" t nil)

;;;***

;;;### (autoloads (pgg-make-scheme-gpg) "pgg-gpg" "../../../../../.emacs.d/el-get/semi/pgg-gpg.el"
;;;;;;  (19831 41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/pgg-gpg.el

(autoload 'pgg-make-scheme-gpg "pgg-gpg" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (pgg-make-scheme-pgp) "pgg-pgp" "../../../../../.emacs.d/el-get/semi/pgg-pgp.el"
;;;;;;  (19831 41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/pgg-pgp.el

(autoload 'pgg-make-scheme-pgp "pgg-pgp" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (pgg-make-scheme-pgp5) "pgg-pgp5" "../../../../../.emacs.d/el-get/semi/pgg-pgp5.el"
;;;;;;  (19831 41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/pgg-pgp5.el

(autoload 'pgg-make-scheme-pgp5 "pgg-pgp5" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (mime-display-application/x-postpet postpet-decode)
;;;;;;  "postpet" "../../../../../.emacs.d/el-get/semi/postpet.el"
;;;;;;  (19831 41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/postpet.el

(autoload 'postpet-decode "postpet" "\
Not documented

\(fn STRING)" nil nil)

(autoload 'mime-display-application/x-postpet "postpet" "\
Not documented

\(fn ENTITY SITUATION)" nil nil)

;;;***

;;;### (autoloads (qmtp-send-buffer qmtp-via-qmtp) "qmtp" "../../../../../.emacs.d/el-get/flim/site-lisp/flim/qmtp.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/qmtp.el

(defvar qmtp-open-connection-function #'open-network-stream)

(autoload 'qmtp-via-qmtp "qmtp" "\
Not documented

\(fn SENDER RECIPIENTS BUFFER)" nil nil)

(autoload 'qmtp-send-buffer "qmtp" "\
Not documented

\(fn SENDER RECIPIENTS BUFFER)" nil nil)

;;;***

;;;### (autoloads (richtext-decode richtext-encode) "richtext" "../../../../../.emacs.d/el-get/apel/site-lisp/emu/richtext.el"
;;;;;;  (19831 41366))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/apel/site-lisp/emu/richtext.el

(autoload 'richtext-encode "richtext" "\
Not documented

\(fn FROM TO)" nil nil)

(autoload 'richtext-decode "richtext" "\
Not documented

\(fn FROM TO)" nil nil)

;;;***

;;;### (autoloads (sha1) "sha1-el" "../../../../../.emacs.d/el-get/flim/site-lisp/flim/sha1-el.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/sha1-el.el

(autoload 'sha1 "sha1-el" "\
Return the SHA1 (Secure Hash Algorithm) of an object.
OBJECT is either a string or a buffer.
Optional arguments BEG and END denote buffer positions for computing the
hash of a portion of OBJECT.
If BINARY is non-nil, return a string in binary form.

\(fn OBJECT &optional BEG END BINARY)" nil nil)

;;;***

;;;### (autoloads (smime-verify-region smime-sign-region smime-decrypt-region
;;;;;;  smime-encrypt-region) "smime" "../../../../../.emacs.d/el-get/semi/smime.el"
;;;;;;  (19831 41438))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/semi/smime.el

(autoload 'smime-encrypt-region "smime" "\
Encrypt the current region between START and END.

\(fn START END)" nil nil)

(autoload 'smime-decrypt-region "smime" "\
Decrypt the current region between START and END.

\(fn START END)" nil nil)

(autoload 'smime-sign-region "smime" "\
Make the signature from text between START and END.
If the optional 3rd argument CLEARTEXT is non-nil, it does not create
a detached signature.

\(fn START END &optional CLEARTEXT)" nil nil)

(autoload 'smime-verify-region "smime" "\
Verify the current region between START and END.
If the optional 3rd argument SIGNATURE is non-nil, it is treated as
the detached signature of the current region.

\(fn START END SIGNATURE)" nil nil)

;;;***

;;;### (autoloads (smtp-send-buffer smtp-via-smtp) "smtp" "../../../../../.emacs.d/el-get/flim/site-lisp/flim/smtp.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/smtp.el

(defvar smtp-open-connection-function #'open-network-stream "\
*Function used for connecting to a SMTP server.
The function will be called with the same four arguments as
`open-network-stream' and should return a process object.
Here is an example:

\(setq smtp-open-connection-function
      #'(lambda (name buffer host service)
	  (let ((process-connection-type nil))
	    (start-process name buffer \"ssh\" \"-C\" host
			   \"nc\" host service))))

It connects to a SMTP server using \"ssh\" before actually connecting
to the SMTP port.  Where the command \"nc\" is the netcat executable;
see http://www.atstake.com/research/tools/index.html#network_utilities
for details.")

(autoload 'smtp-via-smtp "smtp" "\
Like `smtp-send-buffer', but sucks in any errors.

\(fn SENDER RECIPIENTS BUFFER)" nil nil)

(autoload 'smtp-send-buffer "smtp" "\
Send a message.
SENDER is an envelope sender address.
RECIPIENTS is a list of envelope recipient addresses.
BUFFER may be a buffer or a buffer name which contains mail message.

\(fn SENDER RECIPIENTS BUFFER)" nil nil)

;;;***

;;;### (autoloads (std11-extract-address-components std11-parse-msg-ids-string
;;;;;;  std11-parse-msg-id-string std11-parse-addresses-string std11-parse-address-string
;;;;;;  std11-fill-msg-id-list-string std11-msg-id-string std11-full-name-string
;;;;;;  std11-address-string std11-lexical-analyze std11-unfold-string
;;;;;;  std11-field-body std11-narrow-to-header std11-fetch-field)
;;;;;;  "std11" "../../../../../.emacs.d/el-get/flim/site-lisp/flim/std11.el"
;;;;;;  (19831 41426))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/flim/site-lisp/flim/std11.el

(autoload 'std11-fetch-field "std11" "\
Return the value of the header field NAME.
The buffer is expected to be narrowed to just the headers of the message.

\(fn NAME)" nil nil)

(autoload 'std11-narrow-to-header "std11" "\
Narrow to the message header.
If BOUNDARY is not nil, it is used as message header separator.

\(fn &optional BOUNDARY)" nil nil)

(autoload 'std11-field-body "std11" "\
Return the value of the header field NAME.
If BOUNDARY is not nil, it is used as message header separator.

\(fn NAME &optional BOUNDARY)" nil nil)

(autoload 'std11-unfold-string "std11" "\
Unfold STRING as message header field.

\(fn STRING)" nil nil)

(autoload 'std11-lexical-analyze "std11" "\
Analyze STRING as lexical tokens of STD 11.

\(fn STRING &optional ANALYZER START)" nil nil)

(autoload 'std11-address-string "std11" "\
Return string of address part from parsed ADDRESS of RFC 822.

\(fn ADDRESS)" nil nil)

(autoload 'std11-full-name-string "std11" "\
Return string of full-name part from parsed ADDRESS of RFC 822.

\(fn ADDRESS)" nil nil)

(autoload 'std11-msg-id-string "std11" "\
Return string from parsed MSG-ID of RFC 822.

\(fn MSG-ID)" nil nil)

(autoload 'std11-fill-msg-id-list-string "std11" "\
Fill list of msg-id in STRING, and return the result.

\(fn STRING &optional COLUMN)" nil nil)

(autoload 'std11-parse-address-string "std11" "\
Parse STRING as mail address.

\(fn STRING)" nil nil)

(autoload 'std11-parse-addresses-string "std11" "\
Parse STRING as mail address list.

\(fn STRING)" nil nil)

(autoload 'std11-parse-msg-id-string "std11" "\
Parse STRING as msg-id.

\(fn STRING)" nil nil)

(autoload 'std11-parse-msg-ids-string "std11" "\
Parse STRING as `*(phrase / msg-id)'.

\(fn STRING)" nil nil)

(autoload 'std11-extract-address-components "std11" "\
Extract full name and canonical address from STRING.
Returns a list of the form (FULL-NAME CANONICAL-ADDRESS).
If no name can be extracted, FULL-NAME will be nil.

\(fn STRING)" nil nil)

;;;***

;;;### (autoloads (wl-other-frame wl) "wl" "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl.el"
;;;;;;  (19831 41475))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl.el

(autoload 'wl "wl" "\
Start Wanderlust -- Yet Another Message Interface On Emacsen.
If ARG (prefix argument) is specified, folder checkings are skipped.

\(fn &optional ARG)" t nil)

(autoload 'wl-other-frame "wl" "\
Pop up a frame to read messages via Wanderlust.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (wl-addrmgr) "wl-addrmgr" "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-addrmgr.el"
;;;;;;  (19831 41475))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-addrmgr.el

(autoload 'wl-addrmgr "wl-addrmgr" "\
Start an Address manager.

\(fn)" t nil)

;;;***

;;;### (autoloads (wl-user-agent-compose wl-draft) "wl-draft" "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-draft.el"
;;;;;;  (19831 41475))
;;; Generated autoloads from ../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-draft.el

(autoload 'wl-draft "wl-draft" "\
Write and send mail/news message with Wanderlust.

\(fn &optional HEADER-ALIST CONTENT-TYPE CONTENT-TRANSFER-ENCODING BODY EDIT-AGAIN PARENT-FOLDER PARENT-NUMBER)" t nil)

(autoload 'wl-user-agent-compose "wl-draft" "\
Support the `compose-mail' interface for wl.
Only support for TO, SUBJECT, and OTHER-HEADERS has been implemented.
Support for CONTINUE, YANK-ACTION, SEND-ACTIONS and RETURN-ACTION has not
been implemented yet.  Partial support for SWITCH-FUNCTION now supported.

\(fn &optional TO SUBJECT OTHER-HEADERS CONTINUE SWITCH-FUNCTION YANK-ACTION SEND-ACTIONS RETURN-ACTION)" nil nil)

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/el-get/apel/site-lisp/apel/alist.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/apel/calist.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/apel/filename.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/apel/install.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/apel/path-util.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/apel-ver.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/broken.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/emu.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/inv-23.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/invisible.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/mcharset.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/mcs-20.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/mcs-e20.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/mule-caesar.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/pccl-20.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/pccl.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/pces-20.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/pces-e20.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/pces.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/pcustom.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/poe.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/poem-e20.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/poem-e20_3.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/poem.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/product.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/pym.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/richtext.el"
;;;;;;  "../../../../../.emacs.d/el-get/apel/site-lisp/emu/static.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/eword-decode.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/eword-encode.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/hex-util.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/hmac-def.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/hmac-md5.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/hmac-sha1.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/luna.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/lunit.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/md4.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/md5.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel-b-ccl.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel-b-el.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel-g.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel-q-ccl.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel-q.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel-u.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mel.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mime-conf.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mime-def.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mime-parse.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mime.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mmbuffer.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mmcooked.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mmexternal.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/mmgeneric.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/ntlm.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/qmtp.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/sasl-cram.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/sasl-digest.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/sasl-ntlm.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/sasl-scram.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/sasl.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/sha1-el.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/sha1.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/smtp.el"
;;;;;;  "../../../../../.emacs.d/el-get/flim/site-lisp/flim/std11.el"
;;;;;;  "../../../../../.emacs.d/el-get/google-weather/google-weather.el"
;;;;;;  "../../../../../.emacs.d/el-get/google-weather/org-google-weather.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/mail-mime-setup.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/mime-bbdb.el" "../../../../../.emacs.d/el-get/semi/mime-edit.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/mime-image.el" "../../../../../.emacs.d/el-get/semi/mime-mc.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/mime-partial.el" "../../../../../.emacs.d/el-get/semi/mime-pgp.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/mime-play.el" "../../../../../.emacs.d/el-get/semi/mime-setup.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/mime-view.el" "../../../../../.emacs.d/el-get/semi/mime-w3.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/pgg-def.el" "../../../../../.emacs.d/el-get/semi/pgg-gpg.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/pgg-parse.el" "../../../../../.emacs.d/el-get/semi/pgg-pgp.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/pgg-pgp5.el" "../../../../../.emacs.d/el-get/semi/pgg.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/postpet.el" "../../../../../.emacs.d/el-get/semi/semi-def.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/semi-setup.el" "../../../../../.emacs.d/el-get/semi/signature.el"
;;;;;;  "../../../../../.emacs.d/el-get/semi/smime.el" "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/acap.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-access.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-archive.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-cache.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-date.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-dop.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-file.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-filter.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-flag.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-imap4.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-internal.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-localdir.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-localnews.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-maildir.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-map.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-mime.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-msgdb.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-multi.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-net.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-nntp.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-null.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-pipe.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-pop3.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-search.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-sendlog.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-signal.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-spam.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-split.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-util.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-vars.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo-version.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elmo.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elsp-bogofilter.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elsp-bsfilter.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elsp-sa.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/elsp-spamoracle.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/im-wl.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/mmimap.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/modb-entity.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/modb-legacy.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/modb-standard.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/modb.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/pldap.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/rfc2368.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/slp.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/ssl.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/utf7.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-acap.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-action.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-addrbook.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-address.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-addrmgr.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-batch.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-complete.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-demo.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-draft.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-e21.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-expire.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-fldmgr.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-folder.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-highlight.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-mailto.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-message.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-mime.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-news.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-refile.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-score.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-spam.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-summary.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-template.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-thread.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-util.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-vars.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl-version.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/site-lisp/wl/wl.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/utils/bbdb-wl.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/utils/im-wl.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/utils/ptexinfmt.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/utils/rfc2368.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/utils/ssl.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/utils/wl-addrbook.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/utils/wl-complete.el"
;;;;;;  "../../../../../.emacs.d/el-get/wanderlust/utils/wl-mailto.el")
;;;;;;  (19831 41897 89374))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
