(defun run-current-file ()
  "Execute the current file.
For example, if the current buffer is x.py, then it'll call 「python x.py」 in a shell. Output is printed to message buffer.

The file can be Emacs Lisp, PHP, Perl, Python, Ruby, JavaScript, TypeScript, golang, Bash, Ocaml, Visual Basic, TeX, Java, Clojure.
File suffix is used to determine what program to run.

If the file is modified or not saved, save it automatically before run.

URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'
Version 2017-07-31"
  (interactive)
  (let (
        ($suffix-map
         ;; (‹extension› . ‹shell program name›)
         `(
           ("php" . "php")
           ("pl" . "perl")
           ("py" . "python")
           ("py3" . ,(if (string-equal system-type "windows-nt") "c:/Python32/python.exe" "python3"))
           ("rb" . "ruby")
           ("go" . "go run")
           ("hs" . "runhaskell")
           ("js" . "node") ; node.js
           ("ts" . "tsc --alwaysStrict --lib DOM,ES2015,DOM.Iterable,ScriptHost --target ES5") ; TypeScript
           ("sh" . "bash")
           ("clj" . "java -cp /home/xah/apps/clojure-1.6.0/clojure-1.6.0.jar clojure.main")
           ("rkt" . "racket")
           ("ml" . "ocaml")
           ("vbs" . "cscript")
           ("tex" . "pdflatex")
           ("latex" . "pdflatex")
           ("java" . "javac -source 1.8 -target 1.8 -deprecation")
           ;; ("pov" . "/usr/local/bin/povray +R2 +A0.1 +J1.2 +Am2 +Q9 +H480 +W640")
           ))
        $fname
        $fSuffix
        $prog-name
        $cmd-str)
    (when (not (buffer-file-name)) (save-buffer))
    (when (buffer-modified-p) (save-buffer))
    (setq $fname (buffer-file-name))
    (setq $fSuffix (file-name-extension $fname))
    (setq $prog-name (cdr (assoc $fSuffix $suffix-map)))
    (setq $cmd-str (concat $prog-name " \""   $fname "\""))
    (setq $compile-buffer "*compile*")
    (setq $output-buffer "*output*")
    (cond
     ((string-equal $fSuffix "el") (load $fname))
     ((string-equal $fSuffix "go")
      (when (fboundp 'gofmt)
        (gofmt)
        (shell-command $cmd-str "*run-current-file output*" )))
     ((string-equal $fSuffix "java")
      (setq $class-file-name (concat (file-name-sans-extension $fname) ".class"))
      (progn
        (delete-other-windows)

        (shell-command (format "rm -f \"%s\"" $class-file-name))
        (split-window-right)
        (windmove-right)
        (when (get-buffer $compile-buffer) (kill-buffer $compile-buffer))
        (find-file $compile-buffer)

        (split-window-below)
        (when (get-buffer $output-buffer) (kill-buffer $output-buffer))
        (find-file $output-buffer)
      
        (with-output-to-temp-buffer $compile-buffer
          (shell-command $cmd-str $compile-buffer)
          (pop-to-buffer $compile-buffer nil t)
          )
        (when (file-exists-p $class-file-name)
          (with-output-to-temp-buffer $output-buffer
            (shell-command
              (format "java %s" (file-name-sans-extension (file-name-nondirectory $fname))) $output-buffer)
            (pop-to-buffer $output-buffer nil t)
            )
        ))
        (windmove-left)
      )
     (t (if $prog-name
            (progn
              (message "Running…")
              (shell-command $cmd-str "*run-current-file output*" ))
          (message "No recognized program file suffix for this file."))))))

(provide 'run-current-file)
