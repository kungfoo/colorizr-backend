#include "ruby.h"
#include <ctype.h>

static VALUE sorter;
// forward declarations
static void quicksort(VALUE,VALUE,int,int);
static void check_lengths(VALUE, VALUE);
static void check_types(VALUE, VALUE);
static int compare(VALUE a, VALUE b);
static void swap(VALUE,VALUE,int,int);

#define pivot_index() (start+(end-start)/2) // TODO: implement median of three pivoting

// here goes...
static VALUE sort(VALUE self, VALUE scores, VALUE items){
	// sanitiy checks first
	check_types(scores, items);
	check_lengths(scores, items);

	quicksort(scores, items, 0, RARRAY(scores)->len);
	return items;
}

static void quicksort(VALUE scores, VALUE items, int start, int end){
	static VALUE pivot;
	if(end > start){
		int l = start + 1;
		int r = end;

		swap(scores, items, start, pivot_index());
		VALUE pivot = rb_ary_entry(scores, start);

		while(l < r){
			if(compare(rb_ary_entry(scores, l), pivot) <= 0){
				l++;
			}else{
				while(l < --r && compare(rb_ary_entry(scores, r), pivot) >= 0); // skip swaps
				swap(scores, items, l, r);
			}
		}
		l--;
		swap(scores, items, start, l);
		quicksort(scores, items, start, l);
		quicksort(scores, items, r, end);
	}
}

static void swap_s(VALUE arr, int a, int b){
	VALUE t = rb_ary_entry(arr, b);
	rb_ary_store(arr, b, rb_ary_entry(arr, a));
	rb_ary_store(arr, a, t);
}

static void swap(VALUE scores, VALUE items, int a, int b){
	swap_s(scores,a,b);
	swap_s(items, a,b);
}

static int compare(VALUE a, VALUE b){
	VALUE cmp = rb_funcall(a, rb_intern("<=>"), 1, b);
	return NUM2INT(cmp);
}

static void check_types(VALUE scores, VALUE items){
	Check_Type(items, T_ARRAY);
	Check_Type(scores, T_ARRAY);
}

static void check_lengths(VALUE scores, VALUE items){
	int scores_length = RARRAY(scores)->len;
	int items_length = RARRAY(items)->len;
	if(scores_length != items_length){
		rb_raise(rb_eArgError, "The two arrays must have equal size");
	}
}

void Init_colorizr_image_sorter_native(){
	sorter = rb_define_class("ColorizrImageSorter", rb_cObject);
	rb_define_singleton_method(sorter, "sort!", sort, 2);
}