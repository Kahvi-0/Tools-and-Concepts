
[netsec](https://netsec.ws/?p=314)

LM (Lan Manager) hashes:
Originally windows passwords shorter than 15 characters were stored in the Lan Manager (LM) hash format. Some OSes such as Windows 2000, XP and Server 2003 continue to use these hashes unless disabled. Occasionally an OS like Vista may store the LM hash for backwards compatibility with other systems. This hash is simply terrible. It includes several poor design decisions from Microsoft such as splitting the password into two blocks and allowing each to be cracked independently. Through the use of rainbow tables which will be explained later it’s trivial to crack a password stored in a LM hash regardless of complexity. This hash is then stored with the same password calculated in the NT hash format in the following format: ::::::

NT hashes:

Newer Windows operating systems use the NT hash. There is no significant weakness in this hash that sets it apart from any other cryptographic hash function. Cracking methods such as brute force, rainbow tables or word lists are required to recover the password if it’s only stored in the NT format.



SAM (Security Accounts Manager) file will contain system hashes. 

Administrator:500:611D6F6E763B902934544489FCC9192B:B71ED1E7F2B60ED5A2EDD28379D45C91:::
                  ^              LM              ^ ^             NT               ^
                  |                              | |                              |
