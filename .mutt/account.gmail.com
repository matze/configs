# vim: set ft=muttrc

set from                = 'matthias.vogelgesang@gmail.com'
set spoolfile           = '+gmail/INBOX'
set record              = '=gmail/[Gmail]/.Sent Mail'
set postponed           = '=gmail/[Gmail]/.Drafts'
set mbox                = '=gmail/[Gmail]/.All Mail'
set signature           = '~/.mutt/signature.gmail.com'

macro index,pager A "<tag-prefix><save-message>=[Gmail]/.All <enter>"
macro index,pager $ "<sync-mailbox><shell-escape>mbsync gmail-tiny<enter><sync-mailbox>"

folder-hook "=[Gmail]/.All Mail"    source ~/.mutt/sync-macro.all

mailboxes +gmail \
          +gmail/INBOX \
          =gmail/[Gmail]/'.Sent Mail' \
          =gmail/[Gmail]/'.Drafts'
