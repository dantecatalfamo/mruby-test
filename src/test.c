#include <mruby.h>
#include <mruby/compile.h>
#include <mruby/irep.h>
#include "compiled.c"

int main(int argc, char **argv) {
    FILE *fp;
    mrb_state *mrb = mrb_open();
    if (!mrb) {
        puts("No state!");
        return 1;
    }
    mrb_load_string(mrb, "puts 'Hello from a string!'");
    fp = fopen("src/test.rb", "r");
    if (!fp)
        perror("src/test.rb");
    mrb_load_file(mrb, fp);
    mrb_load_irep(mrb, compiled);
    if (mrb->exc) {
        puts("Exception!");
        mrb_print_error(mrb);
    }
    mrb_close(mrb);
    return 0;
}
