#include "rnd/actors/dmchar05.h"

namespace rnd {
  extern "C" {
  void DMChar05_Init(game::act::Actor* actor, game::GlobalContext* gctx) {
    util::GetPointer<void(game::act::Actor*, game::GlobalContext*)>(0x3C6CD8)(actor, gctx);
    // TODO: DETERMINE WHICH MASK AND WHATNOT FROM PARAMS.
    if (actor->params != 0x03)
      Model_SpawnByActor(actor, GetContext().gctx, 0x79);
  }

  void DMChar05_Draw(game::act::Actor* actor, game::GlobalContext* gctx) {
    if (actor->params != 0x03) {
      if (!Model_DrawByActor(actor)) {
        util::GetPointer<void(game::act::Actor*, game::GlobalContext*)>(0x41D1C8)(actor, gctx);
      }
    } else {
      util::GetPointer<void(game::act::Actor*, game::GlobalContext*)>(0x41D1C8)(actor, gctx);
    }
  }

  void DMChar05_Destroy(game::act::Actor* self, game::GlobalContext* gctx) {
    if (self->params != 0x03)
      Model_DestroyByActor(self);
    util::GetPointer<void(game::act::Actor*)>(0x3C6F90)(self);
  }
  }

}  // namespace rnd