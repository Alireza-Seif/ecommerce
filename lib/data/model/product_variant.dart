import 'package:ecommerce/data/model/variant.dart';
import 'package:ecommerce/data/model/variant_type_model.dart';

class ProductVariant {
  VariantType variantType;
  List<Variant> variantList;

   ProductVariant(this.variantType, this.variantList);
}
