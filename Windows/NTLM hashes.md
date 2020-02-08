
[netsec](https://netsec.ws/?p=314)

LM (Lan Manager) hashes:
Originally windows passwords shorter than 15 characters were stored in the Lan Manager (LM) hash format. Some OSes such as Windows 2000, XP and Server 2003 continue to use these hashes unless disabled. Occasionally an OS like Vista may store the LM hash for backwards compatibility with other systems. This hash is simply terrible. It includes several poor design decisions from Microsoft such as splitting the password into two blocks and allowing each to be cracked independently. Through the use of rainbow tables which will be explained later it’s trivial to crack a password stored in a LM hash regardless of complexity. This hash is then stored with the same password calculated in the NT hash format in the following format: ::::::

NT hashes:

Newer Windows operating systems use the NT hash. There is no significant weakness in this hash that sets it apart from any other cryptographic hash function. Cracking methods such as brute force, rainbow tables or word lists are required to recover the password if it’s only stored in the NT format.



SAM (Security Accounts Manager) file will contain system hashes. 

Administrator:500:611D6F6E763B902934544489FCC9192B:B71ED1E7F2B60ED5A2EDD28379D45C91:::
                  ^              LM              ^ ^             NT               ^
                  |                              | |                              |



Note that users who log into a computer in a domain have their hashes stored in memory until the computer is shutoff or rebooted. This means any user that has logged on prior to a reboot can have its credentials/hashes stolen from memory via [Mimikats](https://github.com/Kahvi-0/Tools-and-Concepts/blob/master/Windows/Mimikatz.md)

## NTLM vs. NTLMv1/v2 vs. Net-NTLMv1/v2

NTLMv1/v2 is a shorthand for Net-NTLMv1/v2 and hence are the same thing.

NTLM hashes are stored in the Security Account Manager (SAM) database and in Domain Controller's NTDS.dit database. Can be also obtained using Mimikatz (Windows >= 8.1 you can get NTLM hashes from memory). Some tools just give you the NT hash (e.g. Mimikatz) and that's fine: you can still Pass-The-Hash with just the NT hash.

Net-NTLM hashes are used for network authentication (they are derived from a challenge/response algorithm and are based on the user's NT hash).

From a pentesting perspective:

    You CAN perform Pass-The-Hash attacks with NTLM hashes.

    You CANNOT perform Pass-The-Hash attacks with Net-NTLM hashes.

**You get Net-NTLMv1/v2 (a.k.a NTLMv1/v2) hashes when using tools like Responder or Inveigh. *
