CKEDITOR.editorConfig = function( config )
{
	config.resize_enabled = false;
	config.toolbar = 'Full';
	config.toolbar_Full =
		[
			['Source'],
			['Cut','Copy','Paste','PasteText'],
			['Undo','Redo','-','Find','-','SelectAll','RemoveFormat' ,'-','SpecialChar'],
			['Image','Smiley'],
			'/',
			['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			['NumberedList','BulletedList','-','Outdent','Indent'],
			['JustifyLeft','JustifyCenter','JustifyRight','-', 'Table','HorizontalRule'],
			['Templates','NewPage','Preview'],
			'/',
			['Styles','Format','Font','FontSize'],
			['TextColor','BGColor'],
			['Maximize', 'ShowBlocks']
		];
};
