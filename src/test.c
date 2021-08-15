#include <mruby.h>
#include <mruby/compile.h>

int main(int argc, char **argv) {
    mrb_state *mrb = mrb_open();
    if (!mrb) {
        puts("No state!");
        return 1;
    }
    mrb_load_string(mrb, "puts 'hello, world!'");
    mrb_close(mrb);
    return 0;
}
