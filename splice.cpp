#include <algorithm>
#include <vector>

#include "caffe/util/math_functions.hpp"
#include "caffe/layers/splice.hpp"


namespace caffe {



template <typename Dtype>
void SpliceLayer<Dtype>::LayerSetUp(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top)
{

    num_ = bottom.size();
    LOG(INFO)<<" the bottom size is "<<num_;
      
    const SpliceParameter& splice_param = this->layer_param_.splice_param();
    xcoord_.clear();
    std::copy(splice_param.xcoord().begin(),
    splice_param.xcoord().end(),
      std::back_inserter(xcoord_));

    ycoord_.clear();
    std::copy(splice_param.ycoord().begin(),
    splice_param.ycoord().end(),
      std::back_inserter(ycoord_));
    
}


template <typename Dtype>
void SpliceLayer<Dtype>::Reshape(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top) {

      top[0]->Reshape(bottom[0]->num(), bottom[0]->channels(),
                       bottom[0]->height()*sqrt(num_), bottom[0]->width()*sqrt(num_));

}

/* copy only clipped region */
  template <typename Dtype>
  void SpliceLayer<Dtype>::Forward_cpu(const vector<Blob<Dtype>*>& bottom,
       const vector<Blob<Dtype>*>& top) {


  Dtype* top_data = top[0]->mutable_cpu_data();

  int height_bottom = bottom[0]->height();
  int width_bottom = bottom[0]->width();

  int height_ = height_bottom *sqrt(num_);
  int width_  = width_bottom *sqrt(num_);

  for (int n = 0; n < num_; n++) {//The nth bottom to be concatenated.
     const Dtype* bottom_data = bottom[n]->cpu_data(); 
   
      int v = ycoord_[n];
      int w = xcoord_[n];


     for(int b = 0; b < bottom[0]->num(); b++){

      for(int c = 0; c< bottom[0]->channels(); c++) {
        
        for(int h = v; h<v+height_bottom; h++) {

          int index_bottom = b*c*height_bottom*width_bottom+c*height_bottom*width_bottom + (h-v)*width_bottom;
          int index_top = b*c*height_*width_+c*height_*width_+ h*width_ + w;
          
           for (int i = 0; i <width_bottom; i++) {
             top_data[index_top + i] = bottom_data[index_bottom + i];
           }

        }
      }
    }
  }
  
}

/* copy only clipped region */

  template <typename Dtype>
  void SpliceLayer<Dtype>::Backward_cpu(const vector<Blob<Dtype>*>& top,
      const vector<bool>& propagate_down, const vector<Blob<Dtype>*>& bottom) {

      if (!propagate_down[0]) { return; }

      const Dtype* top_diff = top[0]->cpu_diff();
     
      int height_bottom = bottom[0]->height();
      int width_bottom = bottom[0]->width();

      int height_ = height_bottom *sqrt(num_);
      int width_  = width_bottom *sqrt(num_);

      for (int n = 0; n < num_; n++) {

        Dtype* bottom_diff = bottom[n]->mutable_cpu_diff(); 
         
        int v = ycoord_[n];
        int w = xcoord_[n];

        for (int b = 0; b < bottom[0]->num(); b++){
          
          for(int c = 0; c< bottom[0]->channels(); c++) {
            
            for(int h = v; h<v+height_bottom; h++) {

               int index_bottom = b*c*height_bottom*width_bottom+c*height_bottom*width_bottom + (h-v)*width_bottom;
               int index_top = b*c*height_*width_+c*height_*width_+ h*width_ + w;
               
              for (int i = 0; i < width_bottom; i++) {
                bottom_diff[index_bottom + i] = top_diff[index_top + i];
              }
           
          }// for height and width


          }
        }
      }
  }

#ifdef CPU_ONLY
STUB_GPU(SpliceLayer);
#endif
INSTANTIATE_CLASS(SpliceLayer);
REGISTER_LAYER_CLASS(Splice);
}
