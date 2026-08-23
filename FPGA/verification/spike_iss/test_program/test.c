volatile int result;

int main(void) {
    int a = 0;
    for (int i = 1; i <= 10; i++) {
        a += i * i;
    }
    result = a;          // 385 olmalı
    while (1);
}
