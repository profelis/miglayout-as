package org.jetbrains.migLayout.flex {
import flash.errors.IllegalOperationError;

import mx.core.IVisualElementContainer;

import net.miginfocom.layout.CellConstraint;
import net.miginfocom.layout.ComponentWrapper;
import net.miginfocom.layout.Grid;
import net.miginfocom.layout.LC;
import net.miginfocom.layout.LayoutUtil;

import spark.layouts.supportClasses.LayoutBase;

[Exclude(kind="property", name="clipAndEnableScrolling")]
[Exclude(kind="property", name="typicalLayoutElement")]
[Exclude(kind="property", name="dropIndicator")]
public final class MigLayout extends LayoutBase {
  protected var grid:Grid;
  private var dirty:Boolean = true;
  private var lastHash:int = -1;

  protected var lc:LC;
  protected var colSpecs:Vector.<CellConstraint>, rowSpecs:Vector.<CellConstraint>;

  private var containerWrapper:FlexContainerWrapper;

  public function MigLayout() {
    target
  }

  override public function set useVirtualLayout(value:Boolean):void {
    if (value) {
      throw new IllegalOperationError("MigLayout doesn't support virtual layout");
    }
  }

  override public function elementAdded(index:int):void {
    if (containerWrapper != null) {
      containerWrapper.elementAdded(index);
    }
  }

  override public function elementRemoved(index:int):void {
    if (containerWrapper != null) {
      containerWrapper.elementRemoved(index);
    }
  }

  override public function clearVirtualLayoutCache():void {
    if (containerWrapper != null) {
      containerWrapper.setContainer(IVisualElementContainer(target));
    }
  }

  private function checkCache():void {
    if (target == null) {
      return;
    }

    if (dirty) {
      grid = null;
    }

    if (containerWrapper == null) {
      containerWrapper = new FlexContainerWrapper(IVisualElementContainer(target));
    }

    var hash:int = 0;
    for each (var componentWrapper:ComponentWrapper in containerWrapper.components) {
      hash ^= componentWrapper.layoutHashCode;
      hash += 285134905;
    }
    if (hash != lastHash) {
      grid = null;
      lastHash = hash;
    }

    if (grid == null) {
      grid = new Grid(containerWrapper, lc, rowSpecs, colSpecs);
    }

    dirty = false;
  }

  override public function measure():void {
    checkCache();

    var gW:Vector.<int> = grid.width;
    var gH:Vector.<int> = grid.height;

    target.measuredMinWidth = LayoutUtil.getSizeSafe(gW, LayoutUtil.MIN);
    target.measuredMinHeight = LayoutUtil.getSizeSafe(gH, LayoutUtil.MIN);

    target.measuredWidth = LayoutUtil.getSizeSafe(gW, LayoutUtil.PREF);
    target.measuredHeight = LayoutUtil.getSizeSafe(gH, LayoutUtil.PREF);
  }

  override public function updateDisplayList(w:Number, h:Number):void {
    checkCache();

    if (grid.layout(0, 0, w, h, lc != null && lc.debugMillis > 0, true)) {
      grid = new Grid(containerWrapper, lc, rowSpecs, colSpecs, null);
      grid.layout(0, 0, w, h, lc != null && lc.debugMillis > 0, false);
    }
  }
}
}
