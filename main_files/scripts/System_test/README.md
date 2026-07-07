Bu test içerisinde tasarladığımız MCU, bilgisayardan usb-uart aracılığı ile gönderilen verileri micron flash simülasyon modeline yazmakta, sonrasında boot moduna geçip oradaki verileri tekrar okuyarak kendisini ayağa kaldırmaktadır. Yani çoğu gömülü kartta bulunan boot mekanizmasının tasarımımız üzerinde sorunsuz çalıştığını göstermektedir.

TESTİ YAPMAK İÇİN

1- firmware klasörünün içinde terminal açıp "make sim_main"" kodu ile ilgili kodları derleyin. Başka herhangi bir işlem yapmanıza gerek yok, script bu kodları otomatik ekler.

2- System_test.tcl scriptini anlatıldığı şekilde çalıştırın ve ilgili kodları projeye ekleyin.

3- Artık simülasyon çalışmaya hazır!
