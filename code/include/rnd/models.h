#ifndef _RND_MODELS_H_
#define _RND_MODELS_H_
#include "game/actor.h"
#include "rnd/item_table.h"
namespace rnd {

  typedef struct {
    game::act::Actor* actor;
    ItemRow* itemRow;
    s16 objectId;
    s32 objectModelIndex;
    u8 loaded;
    void* saModel;
    void* saModel2;
    f32 scale;
  } Model;

  void* SkeletonAnimationModel_Spawn(game::act::Actor*, game::GlobalContext*, s16, s32);
  void SkeletonAnimationModel_CopyMtx(void*, void*);
  void Model_SetScale(game::act::Actor*, float);
  void Model_SetMtxAndModel(void*, void*);
  void Model_Draw(void*, int);

} // namespace rnd 
#endif  //_RND_MODELS_H_