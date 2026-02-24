# flutter_body_atlas

An interactive, SVG-based human body atlas for Flutter. High-fidelity anatomical diagrams (currently focused on muscles) with built-in support for hit testing, highlighting, and custom integration.

Designed for fitness apps, medical visualizations, and educational tools that need an interactive map of the human musculoskeletal system.

## Features

- **Interactive Body Views**: Front and back muscle atlas views.
- **Hit Testing**: Detect taps and hovers on specific muscles with accuracy.
- **Dynamic Coloring**: Highlight specific muscles or groups programmatically via stable IDs.
- **ID-Driven Integration**: Use stable SVG element IDs (e.g., `latissimus_dorsi_r`) as a public contract for your business logic.
- **Platform Optimized**: Built-in support for mouse hover on desktop/web and touch interactions on mobile.
- **Customizable**: Inject your own resolvers, localizers, and search implementations.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_body_atlas: ^0.1.0
```

Ensure you include the assets in your `pubspec.yaml` (automatically handled if using the package as a dependency, otherwise ensure the `assets/` folder is accessible).

## Quick Start

The following example demonstrates how to render the front view of the muscle atlas and highlight a set of "engaged" muscles by their stable IDs.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_body_atlas/flutter_body_atlas.dart';

class MuscleHighlightView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // A set of stable IDs you want to highlight (e.g., from a workout)
    final engagedIds = {'biceps_brachii_caput_longum_l', 'rectus_abdominis_1'};

    return BodyAtlasView<MuscleInfo>(
      // Choose between AtlasAsset.musclesFront or AtlasAsset.musclesBack
      view: AtlasAsset.musclesFront,
      
      // Use the built-in MuscleResolver to map SVG IDs to domain objects
      resolver: const MuscleResolver(),
      
      // Map domain objects to specific colors
      colorMapping: {
        for (var id in engagedIds)
          MuscleCatalog.byIdOrThrow(id): Colors.orange,
      },
      
      // Handle user interaction
      onTapElement: (muscle) {
        print('Tapped on: ${muscle.displayName} (ID: ${muscle.id})');
      },
      
      // Optional hover support (Desktop/Web)
      hoverColor: (original) => original.withValues(alpha: 0.5),
      onHoverOverElement: (muscle) {
        // Update state to show tooltip or name
      },
    );
  }
}
```

## ID Stability & Integration

The package treats SVG element IDs as a **stable public contract**. You can rely on these IDs (like `trapezius_1_l`) to remain consistent across versions, allowing you to store them in your own database or use them to trigger application-level logic without fear of them changing.

For a full list of available IDs and their corresponding anatomical names, refer to the `Muscle` enum or the `MuscleCatalog`.

## API Overview

The following types are the primary entry points for the package:

- `BodyAtlasView`: The main widget for rendering and interaction.
- `AtlasAsset`: Enumeration of available SVG diagrams (front/back).
- `MuscleInfo`: Data model containing display names, groups, and IDs.
- `MuscleCatalog`: Static repository of all muscle metadata.
- `MuscleResolver`: Default implementation to resolve SVG IDs into `MuscleInfo`.
- `AtlasResolver`: Interface for custom element resolution.

## Platform Notes

- **Desktop & Web**: Full support for mouse hover via `onHoverOverElement` and `hoverColor`.
- **Mobile**: Optimized for touch. While `onHoverOverElement` is technically available, it is rarely triggered on touch screens.

## Attribution & Licensing

### Assets
The SVG assets included in this package were created by **Ryan Graves** and are used under the **CC BY 4.0** license.
- **Source**: [Figma Community](https://www.figma.com/community/file/1320468164820924031)
- **License**: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

**Note**: Downstream applications using this package must provide clear attribution to Ryan Graves when displaying these assets. See `CREDITS.md` for full attribution details and links.

### Code
The project source code is licensed under the **BSD 3-Clause License**.

## Known Limitations & Roadmap

- **Asset Coverage**: Currently provides a comprehensive muscle atlas. Future layers like skeletal (bones), organ systems, and skin are planned.
- **Taxonomy**: Muscle groupings are currently tailored for fitness/exercise use cases. More medical/anatomical groupings may be added.
- **Z-Order**: Some overlapping paths may require fine-tuning for hit-testing in future updates.
